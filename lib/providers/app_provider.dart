import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../models/app_settings.dart';
import '../models/intake_entry.dart';
import '../services/database_helper.dart';

class AppProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;

  /// Maps the persisted theme string to Flutter's [ThemeMode].
  ThemeMode get themeMode {
    switch (_settings.theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'auto':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  /// Debug‑only: authenticate with a dummy user without touching the DB.
  void debugLogin() {
    _user = UserProfile(
      id: 0,
      name: 'Debug User',
      email: 'debug@test.com',
      weight: 70,
      height: 175,
      age: 25,
      gender: 'male',
      joinDate: DateTime.now().toIso8601String().substring(0, 10),
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  UserProfile _user = const UserProfile(
    name: '',
    email: '',
    weight: 70,
    height: 175,
    age: 25,
    gender: 'male',
    joinDate: '',
  );

  AppSettings _settings = const AppSettings();

  List<IntakeEntry> _entries = [];

  List<Map<String, dynamic>> _weeklyData = [
    {'day': 'Mon', 'amount': 0},
    {'day': 'Tue', 'amount': 0},
    {'day': 'Wed', 'amount': 0},
    {'day': 'Thu', 'amount': 0},
    {'day': 'Fri', 'amount': 0},
    {'day': 'Sat', 'amount': 0},
    {'day': 'Sun', 'amount': 0},
  ];

  int _streak = 0;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  UserProfile get user => _user;
  AppSettings get settings => _settings;
  List<IntakeEntry> get entries => _entries;
  List<Map<String, dynamic>> get weeklyData => _weeklyData;
  int get streak => _streak;

  int get currentIntake => _entries.fold(0, (sum, e) => sum + e.amount);

  String get _todayDate {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  final DatabaseHelper _db = DatabaseHelper.instance;

  /// Login with email and password. Returns error message or null on success.
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _db.loginUser(email, password);
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return 'Неверный email или пароль';
      }

      _user = user;
      _isAuthenticated = true;
      await _loadUserData();

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Ошибка входа: $e';
    }
  }

  /// Register a new user. Returns error message or null on success.
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    double weight = 70,
    double height = 175,
    int age = 25,
    String gender = 'male',
    int goal = 2000,
    String wakeUpTime = '07:00',
    String bedTime = '23:00',
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _db.registerUser(
        name: name,
        email: email,
        password: password,
        weight: weight,
        height: height,
        age: age,
        gender: gender,
      );

      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return 'Этот email уже зарегистрирован';
      }

      _user = user;
      _isAuthenticated = true;

      // Save custom settings from registration
      _settings = AppSettings(
        userId: user.id,
        goal: goal,
        wakeUpTime: wakeUpTime,
        bedTime: bedTime,
      );
      await _db.saveSettings(user.id!, _settings);

      await _loadUserData();

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'Ошибка регистрации: $e';
    }
  }

  Future<void> _loadUserData() async {
    if (_user.id == null) return;

    _settings = await _db.loadSettings(_user.id!);
    _entries = await _db.getIntakeEntries(_user.id!, _todayDate);
    _weeklyData = await _db.getWeeklyData(_user.id!);
    _streak = await _db.getStreak(_user.id!, _settings.goal);
  }

  void logout() {
    _isAuthenticated = false;
    _entries = [];
    _weeklyData = [
      {'day': 'Mon', 'amount': 0},
      {'day': 'Tue', 'amount': 0},
      {'day': 'Wed', 'amount': 0},
      {'day': 'Thu', 'amount': 0},
      {'day': 'Fri', 'amount': 0},
      {'day': 'Sat', 'amount': 0},
      {'day': 'Sun', 'amount': 0},
    ];
    _streak = 0;
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updated) async {
    _user = updated;
    if (_user.id != null) {
      await _db.updateUser(updated);
    }
    notifyListeners();
  }

  Future<void> updateSettings(AppSettings updated) async {
    _settings = updated;
    if (_user.id != null) {
      await _db.saveSettings(_user.id!, updated);
    }
    notifyListeners();
  }

  Future<void> addEntry(IntakeEntry entry) async {
    _entries = [entry, ..._entries];
    notifyListeners();

    await _db.addIntakeEntry(entry);
    // Update weekly data for today
    _weeklyData = await _db.getWeeklyData(_user.id!);
    notifyListeners();
  }

  Future<void> removeEntry(String id) async {
    _entries = _entries.where((e) => e.id != id).toList();
    notifyListeners();

    await _db.deleteIntakeEntry(id);
    _weeklyData = await _db.getWeeklyData(_user.id!);
    notifyListeners();
  }

  Future<void> resetEntries() async {
    // Only remove from in-memory list (for the day)
    _entries = [];
    notifyListeners();
  }
}
