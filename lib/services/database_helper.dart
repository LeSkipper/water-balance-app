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

    final monday = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = monday.add(const Duration(days: 6));

    final mondayStr = '${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
    final sundayStr = '${endOfWeek.year}-${endOfWeek.month.toString().padLeft(2, '0')}-${endOfWeek.day.toString().padLeft(2, '0')}';

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .where('date', isGreaterThanOrEqualTo: mondayStr)
        .where('date', isLessThanOrEqualTo: sundayStr)
        .get();

    final entries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

    for (int i = 0; i < 7; i++) {
      final day = monday.add(Duration(days: i));
      final dateStr = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

      final dailyEntries = entries.where((e) => e.date == dateStr);
      final total = dailyEntries.fold<int>(0, (sum, e) => sum + e.amount);

      days.add({'day': dayNames[i], 'amount': total});
    }

    return days;
  }

  Future<int> getStreak(String userId, int goal) async {
    int streak = 0;
    var checkDate = DateTime.now().subtract(const Duration(days: 1)); // start from yesterday

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('intake_entries')
        .get();
        
    final allEntries = snapshot.docs.map((doc) => IntakeEntry.fromMap(doc.data())).toList();

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
}
