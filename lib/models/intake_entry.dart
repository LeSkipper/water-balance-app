class IntakeEntry {
  final String id;
  final String userId;
  final int amount;
  final String time;
  final String date;

  const IntakeEntry({
    required this.id,
    required this.userId,
    required this.amount,
    required this.time,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'time': time,
      'date': date,
    };
  }

  factory IntakeEntry.fromMap(Map<String, dynamic> map) {
    return IntakeEntry(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      amount: map['amount'] as int,
      time: map['time'] as String,
      date: map['date'] as String,
    );
  }
}
