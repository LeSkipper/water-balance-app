// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Water Balance';

  @override
  String get signIn => 'Anmelden';

  @override
  String get signUp => 'Registrieren';

  @override
  String get signOut => 'Abmelden';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signInSubtitle => 'Melde dich an, um fortzufahren';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get password => 'Passwort';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get or => 'ODER';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get debugLogin => 'Debug Login';

  @override
  String get noAccount => 'Noch kein Konto? ';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto? ';

  @override
  String get back => 'Zurück';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get createAccountSubtitle => 'Starte deine Hydrations-Reise heute';

  @override
  String get fullName => 'Vollständiger Name';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get continueBtn => 'Weiter';

  @override
  String get passwordWeak => 'Schwach';

  @override
  String get passwordMedium => 'Mittel';

  @override
  String get passwordStrong => 'Stark';

  @override
  String get fillAllFields => 'Bitte alle Felder ausfüllen';

  @override
  String get passwordsMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen haben';

  @override
  String get accountCreated => 'Konto erstellt! Auf zur Hydration! 💧';

  @override
  String get aboutYou => 'Über dich';

  @override
  String get aboutYouSubtitle => 'Personalisiere dein Wasserziel';

  @override
  String get weightKg => 'GEWICHT (KG)';

  @override
  String get activityLevel => 'AKTIVITÄTSLEVEL';

  @override
  String get activityLow => 'Niedrig';

  @override
  String get activityModerate => 'Mittel';

  @override
  String get activityHigh => 'Hoch';

  @override
  String get wakeUp => 'Aufwachen';

  @override
  String get wakeUpLabel => 'AUFWAKEN';

  @override
  String get bedTime => 'Schlafenszeit';

  @override
  String get bedTimeLabel => 'SCHLAFENSZEIT';

  @override
  String get recommendedGoal => 'Empfohlenes Tagesziel';

  @override
  String get recommendedGoalSubtitle => 'Basierend auf Gewicht und Aktivität';

  @override
  String hiUser(String name) {
    return 'Hallo, $name';
  }

  @override
  String get stayHydrated => 'Bleib hydriert, bleib gesund';

  @override
  String get quickAdd => 'SCHNELL HINZUFÜGEN';

  @override
  String get todayLog => 'HEUTIGES PROTOKOLL';

  @override
  String entry(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Einträge',
      one: 'Eintrag',
    );
    return '$_temp0';
  }

  @override
  String get dailyReset => '🔄 Tagesaufnahme zurückgesetzt';

  @override
  String addedMl(int amount) {
    return '💧 +$amount ml hinzugefügt';
  }

  @override
  String get goalReachedMsg => '🎉 Tagesziel erreicht!';

  @override
  String get entryRemoved => 'Eintrag entfernt';

  @override
  String ofGoal(int goal) {
    return 'von $goal ml';
  }

  @override
  String get noWaterToday => 'Heute noch keine Einträge';

  @override
  String get tapToStart => 'Tippe auf die Schaltflächen oben';

  @override
  String get customAmount => 'Benutzerdefinierte Menge';

  @override
  String get enterAmountMl => 'Beliebige Menge in ml eingeben';

  @override
  String get add => 'Hinzufügen';

  @override
  String get profile => 'Profil';

  @override
  String get profileUpdated => 'Profil aktualisiert!';

  @override
  String get totalLogged => 'Gesamt getrunken';

  @override
  String get goalsHit => 'Ziele erreicht';

  @override
  String get bestStreak => 'Beste Serie';

  @override
  String get achievementsLabel => 'Errungenschaften';

  @override
  String get bodyInfo => 'KÖRPERINFORMATIONEN';

  @override
  String get weight => 'Gewicht';

  @override
  String get height => 'Größe';

  @override
  String get age => 'Alter';

  @override
  String memberFor(int days) {
    return 'Mitglied seit $days Tagen';
  }

  @override
  String get privacySecurity => 'Datenschutz & Sicherheit';

  @override
  String get helpSupport => 'Hilfe & Support';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get statistics => 'Statistiken';

  @override
  String get statsSubtitle => 'Verfolge deinen Hydrations-Fortschritt';

  @override
  String get avgDaily => 'Täglicher Durchschnitt';

  @override
  String get total => 'Gesamt';

  @override
  String get bestDay => 'Bester Tag';

  @override
  String get monthlyOverview => 'Monatsübersicht';

  @override
  String goalReachedDays(int days) {
    return 'Ziel erreicht ($days Tage)';
  }

  @override
  String get goalReached => 'Ziel erreicht';

  @override
  String get belowGoal => 'Unter dem Ziel';

  @override
  String get achievements => 'ERRUNGENSCHAFTEN';

  @override
  String get hydrationTip => 'Hydrations-Tipp';

  @override
  String get hydrationTipText =>
      'Wasser vor den Mahlzeiten trinken fördert die Verdauung und kann den Appetit reduzieren. Versuche, 30 Minuten vor dem Essen ein Glas zu trinken.';

  @override
  String get thisWeek => 'Diese Woche';

  @override
  String get ach1Title => 'Erster Schluck';

  @override
  String get ach1Desc => 'Ersten Eintrag hinzufügen';

  @override
  String get ach2Title => '7-Tage-Serie';

  @override
  String get ach2Desc => '7 Tage in Folge Ziel erreichen';

  @override
  String get ach3Title => 'Perfekte Woche';

  @override
  String get ach3Desc => 'Jeden Tag 100% der Woche';

  @override
  String get ach4Title => '30-Tage-Krieger';

  @override
  String get ach4Desc => '30-Tage-Serie aufrechterhalten';

  @override
  String get ach5Title => 'Hydrations-Meister';

  @override
  String get ach5Desc => 'Insgesamt 100L trinken';

  @override
  String get ach6Title => 'Ozeantrinker';

  @override
  String get ach6Desc => 'Insgesamt 500L trinken';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsSubtitle => 'Erfahrung anpassen';

  @override
  String get hydrationGoal => 'HYDRATIONSZIEL';

  @override
  String get ml => 'ml';

  @override
  String get measurement => 'MESSUNG';

  @override
  String get unitLabel => 'Einheit';

  @override
  String get unitDesc => 'Volumeneinheit';

  @override
  String get reminders => 'ERINNERUNGEN';

  @override
  String get remindersLabel => 'Erinnerungen';

  @override
  String get remindersDesc => 'Benachrichtigungen zum Trinken';

  @override
  String get interval => 'Intervall';

  @override
  String get intervalDesc => 'Häufigkeit der Erinnerungen';

  @override
  String get soundsHaptics => 'TON & HAPTIK';

  @override
  String get soundEffects => 'Soundeffekte';

  @override
  String get soundEffectsDesc => 'Töne bei Aktionen abspielen';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Haptisches Feedback';

  @override
  String get appearance => 'ERSCHEINUNGSBILD';

  @override
  String get themeLabel => 'Design';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get themeLight => 'light';

  @override
  String get themeDark => 'dark';

  @override
  String get themeAuto => 'auto';

  @override
  String get dataSection => 'DATEN';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportDataDesc => 'Verlauf als CSV herunterladen';

  @override
  String get syncData => 'Daten synchronisieren';

  @override
  String get syncDataDesc => 'Mit der Cloud synchronisieren';

  @override
  String get exportedMsg => 'Daten exportiert! ✅';

  @override
  String get syncedMsg => 'Synchronisiert! ☁️';

  @override
  String get dangerZone => 'GEFAHRENZONE';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get clearAllDataDesc => 'Gesamten Verlauf löschen';

  @override
  String get clearedMsg => '🗑️ Alle Daten gelöscht!';

  @override
  String get appVersion => 'Water Balance v1.0.0';

  @override
  String get madeWith => 'Mit Liebe zur Hydration gemacht 💧';

  @override
  String get min30 => '30 Min';

  @override
  String get hour1 => '1 Stunde';

  @override
  String get hours15 => '1,5 Stunden';

  @override
  String get hours2 => '2 Stunden';

  @override
  String get hours3 => '3 Stunden';

  @override
  String get streakLabel => 'Serie';

  @override
  String streakDays(int count) {
    return '$count Tage';
  }

  @override
  String get avgDay => 'Durch/Tag';

  @override
  String get today => 'Heute';

  @override
  String get done => 'Fertig!';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get resetPasswordDesc => 'E-Mail für den Reset-Link eingeben';

  @override
  String get sendResetLink => 'Reset-Link senden';

  @override
  String get resetEmailSent => 'E-Mail gesendet! Posteingang prüfen.';

  @override
  String get resetEmailError => 'E-Mail konnte nicht gesendet werden.';

  @override
  String get clearDataConfirmTitle => 'Alle Daten löschen?';

  @override
  String get clearDataConfirmMsg =>
      'Die gesamte Trinkwasserhistorie wird unwiderruflich gelöscht.';

  @override
  String get customReminders => 'Benutzerdefinierte Erinnerungen';

  @override
  String get customRemindersDesc =>
      'Spezifische tägliche Erinnerungszeiten hinzufügen';

  @override
  String get addCustomTime => 'Zeit hinzufügen';
}
