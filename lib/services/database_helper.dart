import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import '../models/app_settings.dart';
import '../models/intake_entry.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // --- Auth ---

  Future<UserProfile?> registerUser({
    required String name,
    required String email,
    required String password,
    double weight = 70,
    double height = 175,
    int age = 25,
    String gender = 'male',
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return null;

      final now = DateTime.now();
      final joinDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final userProfile = UserProfile(
        id: user.uid,
        name: name,
        email: email,
        weight: weight,
        height: height,
        age: age,
        gender: gender,
        joinDate: joinDate,
      );

      await _firestore.collection('users').doc(user.uid).set(userProfile.toMap());

      return userProfile;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  Future<UserProfile?> loginUser(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists || doc.data() == null) return null;

      return UserProfile.fromMap(doc.data()!);
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // --- User Profile ---

  Future<void> updateUser(UserProfile user) async {
    if (user.id == null) return;
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // --- Settings ---

  Future<AppSettings> loadSettings(String userId) async {
    final doc = await _firestore.collection('settings').doc(userId).get();
    if (!doc.exists || doc.data() == null) {
      return AppSettings(userId: userId);
    }
    return AppSettings.fromMap(doc.data()!);
  }

  Future<void> saveSettings(String userId, AppSettings settings) async {
    final map = settings.toMap();
    map['user_id'] = userId;
    await _firestore.collection('settings').doc(userId).set(map);
  }

  // --- Intake Entries ---

  Future<void> addIntakeEntry(IntakeEntry entry) async {
    await _firestore
        .collection('users')
        .doc(entry.userId)
        .collection('intake_entries')
        .doc(entry.id)
        .set(entry.toMap());
  }

  Future<List<IntakeEntry>> getIntakeEntries(String userId, String date) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .where('date', isEqualTo: date)
        .get();

    final entries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();
    // Сортировка по убыванию времени
    entries.sort((a, b) => b.time.compareTo(a.time));
    return entries;
  }

  Future<void> deleteIntakeEntry(String userId, String id) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .doc(id)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getWeeklyData(String userId) async {
    final now = DateTime.now();
    final days = <Map<String, dynamic>>[];
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Rolling 7 days: 6 days ago up to today
    final startDate = now.subtract(const Duration(days: 6));

    final startStr = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final endStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .where('date', isGreaterThanOrEqualTo: startStr)
        .where('date', isLessThanOrEqualTo: endStr)
        .get();

    final entries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

    for (int i = 0; i <= 6; i++) {
      final day = startDate.add(Duration(days: i));
      final dateStr = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

      final dailyEntries = entries.where((e) => e.date == dateStr);
      final total = dailyEntries.fold<int>(0, (sum, e) => sum + e.amount);

      days.add({'day': dayNames[day.weekday - 1], 'amount': total});
    }

    return days;
  }

  Future<int> getStreak(String userId, int goal) async {
    int streak = 0;
    
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .get();
        
    final allEntries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

    var checkDate = DateTime.now();
    // Check if goal met today
    final todayStr = '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';
    final todayEntries = allEntries.where((e) => e.date == todayStr);
    final todayTotal = todayEntries.fold<int>(0, (sum, e) => sum + e.amount);

    if (todayTotal >= goal) {
      streak++;
    }

    // Check past days continuously
    checkDate = checkDate.subtract(const Duration(days: 1));
    while (true) {
      final dateStr = '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';
      final dailyEntries = allEntries.where((e) => e.date == dateStr);
      final total = dailyEntries.fold<int>(0, (sum, e) => sum + e.amount);
      
      if (total >= goal) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  Future<List<Map<String, dynamic>>> getMonthlyData(String userId) async {
    final now = DateTime.now();
    final days = <Map<String, dynamic>>[];
    
    // Last 28 days for the monthly chart
    final startDate = now.subtract(const Duration(days: 27));

    final startStr = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final endStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .where('date', isGreaterThanOrEqualTo: startStr)
        .where('date', isLessThanOrEqualTo: endStr)
        .get();

    final entries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

    for (int i = 0; i < 28; i++) {
      final day = startDate.add(Duration(days: i));
      final dateStr = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

      final dailyEntries = entries.where((e) => e.date == dateStr);
      final total = dailyEntries.fold<int>(0, (sum, e) => sum + e.amount);

      days.add({'day': day.day, 'amount': total});
    }

    return days;
  }

  Future<Map<String, dynamic>> getLifetimeStats(String userId, int goal) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .get();
        
    final allEntries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

    if (allEntries.isEmpty) {
      return {
        'totalWaterLogged': 0,
        'goalsHit': 0,
        'bestStreak': 0,
        'totalDaysActive': 0,
      };
    }

    final totalWaterLogged = allEntries.fold<int>(0, (sum, e) => sum + e.amount);
    
    // Group by unique dates
    final Map<String, int> dailyTotals = {};
    for (var e in allEntries) {
      dailyTotals[e.date] = (dailyTotals[e.date] ?? 0) + e.amount;
    }

    int goalsHit = 0;
    for (var amount in dailyTotals.values) {
      if (amount >= goal) goalsHit++;
    }

    // Sort dates
    final sortedDates = dailyTotals.keys.toList()..sort();
    
    int bestStreak = 0;
    int currentStreak = 0;
    DateTime? prevDate;

    for (var dateStr in sortedDates) {
      if (dailyTotals[dateStr]! >= goal) {
        final dateObj = DateTime.parse(dateStr);
        if (prevDate == null || dateObj.difference(prevDate).inDays == 1) {
          currentStreak++;
        } else {
          currentStreak = 1;
        }
        if (currentStreak > bestStreak) bestStreak = currentStreak;
        prevDate = dateObj;
      } else {
        currentStreak = 0;
        prevDate = null;
      }
    }

    return {
      'totalWaterLogged': totalWaterLogged,
      'goalsHit': goalsHit,
      'bestStreak': bestStreak,
      'totalDaysActive': dailyTotals.length,
    };
  }
}
