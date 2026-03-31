// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Water Balance';

  @override
  String get signIn => 'Войти';

  @override
  String get signUp => 'Регистрация';

  @override
  String get signOut => 'Выйти';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get signInSubtitle => 'Войдите, чтобы продолжить';

  @override
  String get emailAddress => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get or => 'ИЛИ';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get debugLogin => 'Debug вход';

  @override
  String get noAccount => 'Нет аккаунта? ';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт? ';

  @override
  String get back => 'Назад';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get createAccountSubtitle => 'Начните путь к здоровью сегодня';

  @override
  String get fullName => 'Полное имя';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get continueBtn => 'Продолжить';

  @override
  String get passwordWeak => 'Слабый';

  @override
  String get passwordMedium => 'Средний';

  @override
  String get passwordStrong => 'Сильный';

  @override
  String get fillAllFields => 'Заполните все поля';

  @override
  String get passwordsMismatch => 'Пароли не совпадают';

  @override
  String get passwordTooShort => 'Пароль минимум 6 символов';

  @override
  String get accountCreated => 'Аккаунт создан! Пора гидратироваться! 💧';

  @override
  String get aboutYou => 'О вас';

  @override
  String get aboutYouSubtitle => 'Настроим цель под вас';

  @override
  String get weightKg => 'ВЕС (КГ)';

  @override
  String get activityLevel => 'УРОВЕНЬ АКТИВНОСТИ';

  @override
  String get activityLow => 'Низкий';

  @override
  String get activityModerate => 'Умеренный';

  @override
  String get activityHigh => 'Высокий';

  @override
  String get wakeUp => 'Подъём';

  @override
  String get wakeUpLabel => 'ПОДЪЁМ';

  @override
  String get bedTime => 'Отбой';

  @override
  String get bedTimeLabel => 'ОТБОЙ';

  @override
  String get recommendedGoal => 'Рекомендуемая суточная цель';

  @override
  String get recommendedGoalSubtitle => 'На основе веса и активности';

  @override
  String hiUser(String name) {
    return 'Привет, $name';
  }

  @override
  String get stayHydrated => 'Пей воду — будь здоров';

  @override
  String get quickAdd => 'БЫСТРОЕ ДОБАВЛЕНИЕ';

  @override
  String get todayLog => 'СЕГОДНЯ';

  @override
  String entry(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'записей',
      few: 'записи',
      one: 'запись',
    );
    return '$_temp0';
  }

  @override
  String get dailyReset => '🔄 Сброс суточного потребления';

  @override
  String addedMl(int amount) {
    return '💧 +$amount мл добавлено';
  }

  @override
  String get goalReachedMsg => '🎉 Суточная цель достигнута!';

  @override
  String get entryRemoved => 'Запись удалена';

  @override
  String ofGoal(int goal) {
    return 'из $goal мл';
  }

  @override
  String get noWaterToday => 'Сегодня ещё нет записей';

  @override
  String get tapToStart => 'Нажмите кнопки выше, чтобы начать';

  @override
  String get customAmount => 'Своё количество';

  @override
  String get enterAmountMl => 'Введите любое количество в мл';

  @override
  String get add => 'Добавить';

  @override
  String get profile => 'Профиль';

  @override
  String get profileUpdated => 'Профиль обновлён!';

  @override
  String get totalLogged => 'Всего выпито';

  @override
  String get goalsHit => 'Целей достигнуто';

  @override
  String get bestStreak => 'Лучшая серия';

  @override
  String get achievementsLabel => 'Достижения';

  @override
  String get bodyInfo => 'ПАРАМЕТРЫ ТЕЛА';

  @override
  String get weight => 'Вес';

  @override
  String get height => 'Рост';

  @override
  String get age => 'Возраст';

  @override
  String memberFor(int days) {
    return 'В приложении $days дн.';
  }

  @override
  String get privacySecurity => 'Конфиденциальность';

  @override
  String get helpSupport => 'Помощь и поддержка';

  @override
  String get rateApp => 'Оценить приложение';

  @override
  String get statistics => 'Статистика';

  @override
  String get statsSubtitle => 'Отслеживайте прогресс';

  @override
  String get avgDaily => 'Среднее в день';

  @override
  String get total => 'Итого';

  @override
  String get bestDay => 'Лучший день';

  @override
  String get monthlyOverview => 'За месяц';

  @override
  String goalReachedDays(int days) {
    return 'Цель достигнута ($days дн.)';
  }

  @override
  String get goalReached => 'Цель достигнута';

  @override
  String get belowGoal => 'Ниже цели';

  @override
  String get achievements => 'ДОСТИЖЕНИЯ';

  @override
  String get hydrationTip => 'Совет по гидратации';

  @override
  String get hydrationTipText =>
      'Вода перед едой помогает пищеварению и может снизить аппетит. Попробуйте выпивать стакан за 30 минут до приёма пищи.';

  @override
  String get thisWeek => 'Эта неделя';

  @override
  String get ach1Title => 'Первый глоток';

  @override
  String get ach1Desc => 'Добавьте первый стакан воды';

  @override
  String get ach2Title => '7 дней подряд';

  @override
  String get ach2Desc => 'Достигайте цели 7 дней';

  @override
  String get ach3Title => 'Идеальная неделя';

  @override
  String get ach3Desc => '100% каждый день недели';

  @override
  String get ach4Title => '30-дневный воин';

  @override
  String get ach4Desc => 'Серия 30 дней';

  @override
  String get ach5Title => 'Мастер гидратации';

  @override
  String get ach5Desc => 'Выпейте 100 л суммарно';

  @override
  String get ach6Title => 'Океан';

  @override
  String get ach6Desc => 'Выпейте 500 л суммарно';

  @override
  String get settings => 'Настройки';

  @override
  String get settingsSubtitle => 'Настройте под себя';

  @override
  String get hydrationGoal => 'ЦЕЛЬ ГИДРАТАЦИИ';

  @override
  String get ml => 'мл';

  @override
  String get measurement => 'ИЗМЕРЕНИЯ';

  @override
  String get unitLabel => 'Единица';

  @override
  String get unitDesc => 'Единица объёма';

  @override
  String get reminders => 'НАПОМИНАНИЯ';

  @override
  String get remindersLabel => 'Напоминания';

  @override
  String get remindersDesc => 'Уведомления о воде';

  @override
  String get interval => 'Интервал';

  @override
  String get intervalDesc => 'Частота напоминаний';

  @override
  String get soundsHaptics => 'ЗВУК И ВИБРАЦИЯ';

  @override
  String get soundEffects => 'Звуковые эффекты';

  @override
  String get soundEffectsDesc => 'Звук при добавлении';

  @override
  String get vibration => 'Вибрация';

  @override
  String get vibrationDesc => 'Тактильная отдача';

  @override
  String get appearance => 'ВНЕШНИЙ ВИД';

  @override
  String get themeLabel => 'Тема';

  @override
  String get languageLabel => 'Язык';

  @override
  String get themeLight => 'light';

  @override
  String get themeDark => 'dark';

  @override
  String get themeAuto => 'auto';

  @override
  String get dataSection => 'ДАННЫЕ';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get exportDataDesc => 'Скачать историю в CSV';

  @override
  String get syncData => 'Синхронизация';

  @override
  String get syncDataDesc => 'Синхронизировать с облаком';

  @override
  String get exportedMsg => 'Данные экспортированы! ✅';

  @override
  String get syncedMsg => 'Синхронизация выполнена! ☁️';

  @override
  String get dangerZone => 'ОПАСНАЯ ЗОНА';

  @override
  String get clearAllData => 'Очистить данные';

  @override
  String get clearAllDataDesc => 'Удалить всю историю потребления';

  @override
  String get clearedMsg => '🗑️ Все данные очищены!';

  @override
  String get appVersion => 'Water Balance v1.0.0';

  @override
  String get madeWith => 'Сделано с любовью к гидратации 💧';

  @override
  String get min30 => '30 мин';

  @override
  String get hour1 => '1 час';

  @override
  String get hours15 => '1.5 часа';

  @override
  String get hours2 => '2 часа';

  @override
  String get hours3 => '3 часа';

  @override
  String get streakLabel => 'Серия';

  @override
  String streakDays(int count) {
    return '$count дн.';
  }

  @override
  String get avgDay => 'Сред/день';

  @override
  String get today => 'Сегодня';

  @override
  String get done => 'Готово!';
}
