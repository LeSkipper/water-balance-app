class AppSettings {
  final String? id;
  final String? userId;
  final int goal;
  final String unit;
  final bool reminderEnabled;
  final int reminderInterval;
  final String wakeUpTime;
  final String bedTime;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final String theme;
  final String language;

  const AppSettings({
    this.id,
    this.userId,
    this.goal = 2000,
    this.unit = 'ml',
    this.reminderEnabled = true,
    this.reminderInterval = 60,
    this.wakeUpTime = '07:00',
    this.bedTime = '23:00',
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.theme = 'light',
    this.language = 'English',
  });

  AppSettings copyWith({
    String? id,
    String? userId,
    int? goal,
    String? unit,
    bool? reminderEnabled,
    int? reminderInterval,
    String? wakeUpTime,
    String? bedTime,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? theme,
    String? language,
  }) {
    return AppSettings(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goal: goal ?? this.goal,
      unit: unit ?? this.unit,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderInterval: reminderInterval ?? this.reminderInterval,
      wakeUpTime: wakeUpTime ?? this.wakeUpTime,
      bedTime: bedTime ?? this.bedTime,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'goal': goal,
      'unit': unit,
      'reminder_enabled': reminderEnabled ? 1 : 0,
      'reminder_interval': reminderInterval,
      'wake_up_time': wakeUpTime,
      'bed_time': bedTime,
      'sound_enabled': soundEnabled ? 1 : 0,
      'vibration_enabled': vibrationEnabled ? 1 : 0,
      'theme': theme,
      'language': language,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      id: map['id'] as String?,
      userId: map['user_id'] as String?,
      goal: map['goal'] as int,
      unit: map['unit'] as String,
      reminderEnabled: (map['reminder_enabled'] as int) == 1,
      reminderInterval: map['reminder_interval'] as int,
      wakeUpTime: map['wake_up_time'] as String,
      bedTime: map['bed_time'] as String,
      soundEnabled: (map['sound_enabled'] as int) == 1,
      vibrationEnabled: (map['vibration_enabled'] as int) == 1,
      theme: map['theme'] as String,
      language: map['language'] as String,
    );
  }
}
