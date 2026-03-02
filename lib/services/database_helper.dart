import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/user_profile.dart';
import '../models/app_settings.dart';
import '../models/intake_entry.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'water_balance.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        avatar TEXT DEFAULT '',
        weight REAL NOT NULL DEFAULT 70,
        height REAL NOT NULL DEFAULT 175,
        age INTEGER NOT NULL DEFAULT 25,
        gender TEXT NOT NULL DEFAULT 'male',
        join_date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL UNIQUE,
        goal INTEGER NOT NULL DEFAULT 2000,
        unit TEXT NOT NULL DEFAULT 'ml',
        reminder_enabled INTEGER NOT NULL DEFAULT 1,
        reminder_interval INTEGER NOT NULL DEFAULT 60,
        wake_up_time TEXT NOT NULL DEFAULT '07:00',
        bed_time TEXT NOT NULL DEFAULT '23:00',
        sound_enabled INTEGER NOT NULL DEFAULT 1,
        vibration_enabled INTEGER NOT NULL DEFAULT 1,
        theme TEXT NOT NULL DEFAULT 'light',
        language TEXT NOT NULL DEFAULT 'English',
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE intake_entries (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        amount INTEGER NOT NULL,
        time TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');
  }

  // --- Auth ---

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  /// Register a new user. Returns the UserProfile or null if email already taken.
  Future<UserProfile?> registerUser({
    required String name,
    required String email,
    required String password,
    double weight = 70,
    double height = 175,
    int age = 25,
    String gender = 'male',
  }) async {
    final db = await database;

    // Check if email already exists
    final existing = await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (existing.isNotEmpty) return null;

    final now = DateTime.now();
    final joinDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final id = await db.insert('users', {
      'name': name,
      'email': email,
      'password_hash': _hashPassword(password),
      'avatar': '',
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
      'join_date': joinDate,
    });

    // Create default settings for the user
    await db.insert('settings', {
      'user_id': id,
      'goal': 2000,
      'unit': 'ml',
      'reminder_enabled': 1,
      'reminder_interval': 60,
      'wake_up_time': '07:00',
      'bed_time': '23:00',
      'sound_enabled': 1,
      'vibration_enabled': 1,
      'theme': 'light',
      'language': 'English',
    });

    return UserProfile(
      id: id,
      name: name,
      email: email,
      weight: weight,
      height: height,
      age: age,
      gender: gender,
      joinDate: joinDate,
    );
  }

  /// Login with email and password. Returns UserProfile or null if invalid.
  Future<UserProfile?> loginUser(String email, String password) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, _hashPassword(password)],
    );
    if (results.isEmpty) return null;
    return UserProfile.fromMap(results.first);
  }

  // --- User Profile ---

  Future<void> updateUser(UserProfile user) async {
    final db = await database;
    final map = user.toMap();
    map.remove('id');
    await db.update('users', map, where: 'id = ?', whereArgs: [user.id]);
  }

  // --- Settings ---

  Future<AppSettings> loadSettings(int userId) async {
    final db = await database;
    final results = await db.query('settings', where: 'user_id = ?', whereArgs: [userId]);
    if (results.isEmpty) return AppSettings(userId: userId);
    return AppSettings.fromMap(results.first);
  }

  Future<void> saveSettings(int userId, AppSettings settings) async {
    final db = await database;
    final map = settings.toMap();
    map['user_id'] = userId;
    map.remove('id');

    final existing = await db.query('settings', where: 'user_id = ?', whereArgs: [userId]);
    if (existing.isEmpty) {
      await db.insert('settings', map);
    } else {
      await db.update('settings', map, where: 'user_id = ?', whereArgs: [userId]);
    }
  }

  // --- Intake Entries ---

  Future<void> addIntakeEntry(IntakeEntry entry) async {
    final db = await database;
    await db.insert('intake_entries', entry.toMap());
  }

  Future<List<IntakeEntry>> getIntakeEntries(int userId, String date) async {
    final db = await database;
    final results = await db.query(
      'intake_entries',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
      orderBy: 'rowid DESC',
    );
    return results.map((m) => IntakeEntry.fromMap(m)).toList();
  }

  Future<void> deleteIntakeEntry(String id) async {
    final db = await database;
    await db.delete('intake_entries', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getWeeklyData(int userId) async {
    final db = await database;
    final now = DateTime.now();
    final days = <Map<String, dynamic>>[];
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Find the Monday of the current week
    final monday = now.subtract(Duration(days: now.weekday - 1));

    for (int i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      final dateStr = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

      final result = await db.rawQuery(
        'SELECT COALESCE(SUM(amount), 0) as total FROM intake_entries WHERE user_id = ? AND date = ?',
        [userId, dateStr],
      );

      final total = (result.first['total'] as num?)?.toInt() ?? 0;
      days.add({'day': dayNames[i], 'amount': total});
    }

    return days;
  }

  Future<int> getStreak(int userId, int goal) async {
    final db = await database;
    int streak = 0;
    var checkDate = DateTime.now().subtract(const Duration(days: 1)); // start from yesterday

    while (true) {
      final dateStr = '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';
      final result = await db.rawQuery(
        'SELECT COALESCE(SUM(amount), 0) as total FROM intake_entries WHERE user_id = ? AND date = ?',
        [userId, dateStr],
      );
      final total = (result.first['total'] as num?)?.toInt() ?? 0;
      if (total >= goal) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }
}
