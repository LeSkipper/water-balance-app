// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Water Balance';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signOut => 'Log Out';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInSubtitle => 'Sign in to continue your hydration journey';

  @override
  String get emailAddress => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get or => 'OR';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get debugLogin => 'Debug Login';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get back => 'Back';

  @override
  String get createAccount => 'Create Account';

  @override
  String get createAccountSubtitle => 'Start your hydration journey today';

  @override
  String get fullName => 'Full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get continueBtn => 'Continue';

  @override
  String get passwordWeak => 'Weak';

  @override
  String get passwordMedium => 'Medium';

  @override
  String get passwordStrong => 'Strong';

  @override
  String get fillAllFields => 'Please fill in all fields';

  @override
  String get passwordsMismatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get accountCreated => 'Account created! Let\'s get hydrated! 💧';

  @override
  String get aboutYou => 'About You';

  @override
  String get aboutYouSubtitle => 'Help us personalize your water goal';

  @override
  String get weightKg => 'WEIGHT (KG)';

  @override
  String get activityLevel => 'ACTIVITY LEVEL';

  @override
  String get activityLow => 'Low';

  @override
  String get activityModerate => 'Moderate';

  @override
  String get activityHigh => 'High';

  @override
  String get wakeUp => 'Wake Up';

  @override
  String get wakeUpLabel => 'WAKE UP';

  @override
  String get bedTime => 'Bed Time';

  @override
  String get bedTimeLabel => 'BED TIME';

  @override
  String get recommendedGoal => 'Recommended Daily Goal';

  @override
  String get recommendedGoalSubtitle =>
      'Based on your weight and activity level';

  @override
  String hiUser(String name) {
    return 'Hi, $name';
  }

  @override
  String get stayHydrated => 'Stay hydrated, stay healthy';

  @override
  String get quickAdd => 'QUICK ADD';

  @override
  String get todayLog => 'TODAY\'S LOG';

  @override
  String entry(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'entries',
      one: 'entry',
    );
    return '$_temp0';
  }

  @override
  String get dailyReset => '🔄 Daily intake reset';

  @override
  String addedMl(int amount) {
    return '💧 +$amount ml added';
  }

  @override
  String get goalReachedMsg => '🎉 You\'ve reached your daily goal!';

  @override
  String get entryRemoved => 'Entry removed';

  @override
  String ofGoal(int goal) {
    return 'of $goal ml';
  }

  @override
  String get noWaterToday => 'No water logged yet today';

  @override
  String get tapToStart => 'Tap the buttons above to start';

  @override
  String get customAmount => 'Custom amount';

  @override
  String get enterAmountMl => 'Enter any amount in ml';

  @override
  String get add => 'Add';

  @override
  String get profile => 'Profile';

  @override
  String get profileUpdated => 'Profile updated!';

  @override
  String get totalLogged => 'Total Logged';

  @override
  String get goalsHit => 'Goals Hit';

  @override
  String get bestStreak => 'Best Streak';

  @override
  String get achievementsLabel => 'Achievements';

  @override
  String get bodyInfo => 'BODY INFORMATION';

  @override
  String get weight => 'Weight';

  @override
  String get height => 'Height';

  @override
  String get age => 'Age';

  @override
  String memberFor(int days) {
    return 'Member for $days days';
  }

  @override
  String get privacySecurity => 'Privacy & Security';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get rateApp => 'Rate the App';

  @override
  String get statistics => 'Statistics';

  @override
  String get statsSubtitle => 'Track your hydration progress';

  @override
  String get avgDaily => 'Avg. Daily';

  @override
  String get total => 'Total';

  @override
  String get bestDay => 'Best Day';

  @override
  String get monthlyOverview => 'Monthly Overview';

  @override
  String goalReachedDays(int days) {
    return 'Goal reached ($days days)';
  }

  @override
  String get goalReached => 'Goal reached';

  @override
  String get belowGoal => 'Below goal';

  @override
  String get achievements => 'ACHIEVEMENTS';

  @override
  String get hydrationTip => 'Hydration Tip';

  @override
  String get hydrationTipText =>
      'Drinking water before meals can help with digestion and may reduce calorie intake. Try having a glass 30 minutes before eating.';

  @override
  String get thisWeek => 'This Week';

  @override
  String get ach1Title => 'First Sip';

  @override
  String get ach1Desc => 'Log your first glass';

  @override
  String get ach2Title => '7-Day Streak';

  @override
  String get ach2Desc => 'Reach goal 7 days in a row';

  @override
  String get ach3Title => 'Perfect Week';

  @override
  String get ach3Desc => 'Hit 100% every day for a week';

  @override
  String get ach4Title => '30-Day Warrior';

  @override
  String get ach4Desc => 'Maintain a 30-day streak';

  @override
  String get ach5Title => 'Hydration Master';

  @override
  String get ach5Desc => 'Drink 100L total';

  @override
  String get ach6Title => 'Ocean Drinker';

  @override
  String get ach6Desc => 'Drink 500L total';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Customize your experience';

  @override
  String get hydrationGoal => 'HYDRATION GOAL';

  @override
  String get ml => 'ml';

  @override
  String get measurement => 'MEASUREMENT';

  @override
  String get unitLabel => 'Unit';

  @override
  String get unitDesc => 'Volume measurement unit';

  @override
  String get reminders => 'REMINDERS';

  @override
  String get remindersLabel => 'Reminders';

  @override
  String get remindersDesc => 'Get notified to drink water';

  @override
  String get interval => 'Interval';

  @override
  String get intervalDesc => 'How often to remind';

  @override
  String get soundsHaptics => 'SOUNDS & HAPTICS';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get soundEffectsDesc => 'Play sounds on actions';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Haptic feedback';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get themeLabel => 'Theme';

  @override
  String get languageLabel => 'Language';

  @override
  String get themeLight => 'light';

  @override
  String get themeDark => 'dark';

  @override
  String get themeAuto => 'auto';

  @override
  String get dataSection => 'DATA';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportDataDesc => 'Download your history as CSV';

  @override
  String get syncData => 'Sync Data';

  @override
  String get syncDataDesc => 'Sync with cloud storage';

  @override
  String get exportedMsg => 'Data exported! ✅';

  @override
  String get syncedMsg => 'Data synced! ☁️';

  @override
  String get dangerZone => 'DANGER ZONE';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearAllDataDesc => 'Delete all water intake history';

  @override
  String get clearedMsg => '🗑️ All data cleared!';

  @override
  String get appVersion => 'Water Balance v1.0.0';

  @override
  String get madeWith => 'Made with love for hydration 💧';

  @override
  String get min30 => '30 min';

  @override
  String get hour1 => '1 hour';

  @override
  String get hours15 => '1.5 hours';

  @override
  String get hours2 => '2 hours';

  @override
  String get hours3 => '3 hours';

  @override
  String get streakLabel => 'Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String get avgDay => 'Avg/day';

  @override
  String get today => 'Today';

  @override
  String get done => 'Done!';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordDesc => 'Enter your email to receive a reset link';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get resetEmailSent => 'Reset email sent! Check your inbox.';

  @override
  String get resetEmailError =>
      'Could not send reset email. Check the address.';

  @override
  String get clearDataConfirmTitle => 'Clear All Data?';

  @override
  String get clearDataConfirmMsg =>
      'This will permanently delete all your water intake history. This cannot be undone.';

  @override
  String get customReminders => 'Custom Reminders';

  @override
  String get customRemindersDesc => 'Add specific daily reminder times';

  @override
  String get addCustomTime => 'Add time';
}
