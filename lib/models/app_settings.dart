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
  final List<String> customTimes;

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
    this.customTimes = const [],
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
    List<String>? customTimes,
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
      customTimes: customTimes ?? this.customTimes,
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
      'custom_times': customTimes,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    bool _parseBool(dynamic v) {
      if (v is bool) return v;
      if (v is int) return v == 1;
      return false;
    }
    return AppSettings(
      id: map['id'] as String?,
      userId: map['user_id'] as String?,
      goal: (map['goal'] as num).toInt(),
      unit: map['unit'] as String? ?? 'ml',
      reminderEnabled: _parseBool(map['reminder_enabled']),
      reminderInterval: (map['reminder_interval'] as num).toInt(),
      wakeUpTime: map['wake_up_time'] as String? ?? '07:00',
      bedTime: map['bed_time'] as String? ?? '23:00',
      soundEnabled: _parseBool(map['sound_enabled']),
      vibrationEnabled: _parseBool(map['vibration_enabled']),
      theme: map['theme'] as String? ?? 'light',
      language: map['language'] as String? ?? 'English',
      customTimes: (map['custom_times'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
