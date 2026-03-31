class UserProfile {
  final String? id;
  final String name;
  final String email;
  final String avatar;
  final double weight;
  final double height;
  final int age;
  final String gender;
  final String joinDate;

  const UserProfile({
    this.id,
    required this.name,
    required this.email,
    this.avatar = '',
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.joinDate,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    double? weight,
    double? height,
    int? age,
    String? gender,
    String? joinDate,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
      'join_date': joinDate,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      avatar: (map['avatar'] as String?) ?? '',
      weight: (map['weight'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
      age: map['age'] as int,
      gender: map['gender'] as String,
      joinDate: map['join_date'] as String,
    );
  }
}
