import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ru')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Water Balance'**
  String get appName;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get signOut;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your hydration journey'**
  String get signInSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @debugLogin.
  ///
  /// In en, this message translates to:
  /// **'Debug Login'**
  String get debugLogin;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start your hydration journey today'**
  String get createAccountSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @passwordWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordWeak;

  /// No description provided for @passwordMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordMedium;

  /// No description provided for @passwordStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrong;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get fillAllFields;

  /// No description provided for @passwordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsMismatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created! Let\'s get hydrated! 💧'**
  String get accountCreated;

  /// No description provided for @aboutYou.
  ///
  /// In en, this message translates to:
  /// **'About You'**
  String get aboutYou;

  /// No description provided for @aboutYouSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us personalize your water goal'**
  String get aboutYouSubtitle;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT (KG)'**
  String get weightKg;

  /// No description provided for @activityLevel.
  ///
  /// In en, this message translates to:
  /// **'ACTIVITY LEVEL'**
  String get activityLevel;

  /// No description provided for @activityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get activityLow;

  /// No description provided for @activityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get activityModerate;

  /// No description provided for @activityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get activityHigh;

  /// No description provided for @wakeUp.
  ///
  /// In en, this message translates to:
  /// **'Wake Up'**
  String get wakeUp;

  /// No description provided for @wakeUpLabel.
  ///
  /// In en, this message translates to:
  /// **'WAKE UP'**
  String get wakeUpLabel;

  /// No description provided for @bedTime.
  ///
  /// In en, this message translates to:
  /// **'Bed Time'**
  String get bedTime;

  /// No description provided for @bedTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'BED TIME'**
  String get bedTimeLabel;

  /// No description provided for @recommendedGoal.
  ///
  /// In en, this message translates to:
  /// **'Recommended Daily Goal'**
  String get recommendedGoal;

  /// No description provided for @recommendedGoalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your weight and activity level'**
  String get recommendedGoalSubtitle;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String hiUser(String name);

  /// No description provided for @stayHydrated.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated, stay healthy'**
  String get stayHydrated;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'QUICK ADD'**
  String get quickAdd;

  /// No description provided for @todayLog.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S LOG'**
  String get todayLog;

  /// No description provided for @entry.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{entry} other{entries}}'**
  String entry(int count);

  /// No description provided for @dailyReset.
  ///
  /// In en, this message translates to:
  /// **'🔄 Daily intake reset'**
  String get dailyReset;

  /// No description provided for @addedMl.
  ///
  /// In en, this message translates to:
  /// **'💧 +{amount} ml added'**
  String addedMl(int amount);

  /// No description provided for @goalReachedMsg.
  ///
  /// In en, this message translates to:
  /// **'🎉 You\'ve reached your daily goal!'**
  String get goalReachedMsg;

  /// No description provided for @entryRemoved.
  ///
  /// In en, this message translates to:
  /// **'Entry removed'**
  String get entryRemoved;

  /// No description provided for @ofGoal.
  ///
  /// In en, this message translates to:
  /// **'of {goal} ml'**
  String ofGoal(int goal);

  /// No description provided for @noWaterToday.
  ///
  /// In en, this message translates to:
  /// **'No water logged yet today'**
  String get noWaterToday;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap the buttons above to start'**
  String get tapToStart;

  /// No description provided for @customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom amount'**
  String get customAmount;

  /// No description provided for @enterAmountMl.
  ///
  /// In en, this message translates to:
  /// **'Enter any amount in ml'**
  String get enterAmountMl;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated!'**
  String get profileUpdated;

  /// No description provided for @totalLogged.
  ///
  /// In en, this message translates to:
  /// **'Total Logged'**
  String get totalLogged;

  /// No description provided for @goalsHit.
  ///
  /// In en, this message translates to:
  /// **'Goals Hit'**
  String get goalsHit;

  /// No description provided for @bestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get bestStreak;

  /// No description provided for @achievementsLabel.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsLabel;

  /// No description provided for @bodyInfo.
  ///
  /// In en, this message translates to:
  /// **'BODY INFORMATION'**
  String get bodyInfo;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @memberFor.
  ///
  /// In en, this message translates to:
  /// **'Member for {days} days'**
  String memberFor(int days);

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the App'**
  String get rateApp;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @statsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your hydration progress'**
  String get statsSubtitle;

  /// No description provided for @avgDaily.
  ///
  /// In en, this message translates to:
  /// **'Avg. Daily'**
  String get avgDaily;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @bestDay.
  ///
  /// In en, this message translates to:
  /// **'Best Day'**
  String get bestDay;

  /// No description provided for @monthlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly Overview'**
  String get monthlyOverview;

  /// No description provided for @goalReachedDays.
  ///
  /// In en, this message translates to:
  /// **'Goal reached ({days} days)'**
  String goalReachedDays(int days);

  /// No description provided for @goalReached.
  ///
  /// In en, this message translates to:
  /// **'Goal reached'**
  String get goalReached;

  /// No description provided for @belowGoal.
  ///
  /// In en, this message translates to:
  /// **'Below goal'**
  String get belowGoal;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'ACHIEVEMENTS'**
  String get achievements;

  /// No description provided for @hydrationTip.
  ///
  /// In en, this message translates to:
  /// **'Hydration Tip'**
  String get hydrationTip;

  /// No description provided for @hydrationTipText.
  ///
  /// In en, this message translates to:
  /// **'Drinking water before meals can help with digestion and may reduce calorie intake. Try having a glass 30 minutes before eating.'**
  String get hydrationTipText;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @ach1Title.
  ///
  /// In en, this message translates to:
  /// **'First Sip'**
  String get ach1Title;

  /// No description provided for @ach1Desc.
  ///
  /// In en, this message translates to:
  /// **'Log your first glass'**
  String get ach1Desc;

  /// No description provided for @ach2Title.
  ///
  /// In en, this message translates to:
  /// **'7-Day Streak'**
  String get ach2Title;

  /// No description provided for @ach2Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach goal 7 days in a row'**
  String get ach2Desc;

  /// No description provided for @ach3Title.
  ///
  /// In en, this message translates to:
  /// **'Perfect Week'**
  String get ach3Title;

  /// No description provided for @ach3Desc.
  ///
  /// In en, this message translates to:
  /// **'Hit 100% every day for a week'**
  String get ach3Desc;

  /// No description provided for @ach4Title.
  ///
  /// In en, this message translates to:
  /// **'30-Day Warrior'**
  String get ach4Title;

  /// No description provided for @ach4Desc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 30-day streak'**
  String get ach4Desc;

  /// No description provided for @ach5Title.
  ///
  /// In en, this message translates to:
  /// **'Hydration Master'**
  String get ach5Title;

  /// No description provided for @ach5Desc.
  ///
  /// In en, this message translates to:
  /// **'Drink 100L total'**
  String get ach5Desc;

  /// No description provided for @ach6Title.
  ///
  /// In en, this message translates to:
  /// **'Ocean Drinker'**
  String get ach6Title;

  /// No description provided for @ach6Desc.
  ///
  /// In en, this message translates to:
  /// **'Drink 500L total'**
  String get ach6Desc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience'**
  String get settingsSubtitle;

  /// No description provided for @hydrationGoal.
  ///
  /// In en, this message translates to:
  /// **'HYDRATION GOAL'**
  String get hydrationGoal;

  /// No description provided for @ml.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get ml;

  /// No description provided for @measurement.
  ///
  /// In en, this message translates to:
  /// **'MEASUREMENT'**
  String get measurement;

  /// No description provided for @unitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitLabel;

  /// No description provided for @unitDesc.
  ///
  /// In en, this message translates to:
  /// **'Volume measurement unit'**
  String get unitDesc;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'REMINDERS'**
  String get reminders;

  /// No description provided for @remindersLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersLabel;

  /// No description provided for @remindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified to drink water'**
  String get remindersDesc;

  /// No description provided for @interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get interval;

  /// No description provided for @intervalDesc.
  ///
  /// In en, this message translates to:
  /// **'How often to remind'**
  String get intervalDesc;

  /// No description provided for @soundsHaptics.
  ///
  /// In en, this message translates to:
  /// **'SOUNDS & HAPTICS'**
  String get soundsHaptics;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @soundEffectsDesc.
  ///
  /// In en, this message translates to:
  /// **'Play sounds on actions'**
  String get soundEffectsDesc;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @vibrationDesc.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get vibrationDesc;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'dark'**
  String get themeDark;

  /// No description provided for @themeAuto.
  ///
  /// In en, this message translates to:
  /// **'auto'**
  String get themeAuto;

  /// No description provided for @dataSection.
  ///
  /// In en, this message translates to:
  /// **'DATA'**
  String get dataSection;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Download your history as CSV'**
  String get exportDataDesc;

  /// No description provided for @syncData.
  ///
  /// In en, this message translates to:
  /// **'Sync Data'**
  String get syncData;

  /// No description provided for @syncDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Sync with cloud storage'**
  String get syncDataDesc;

  /// No description provided for @exportedMsg.
  ///
  /// In en, this message translates to:
  /// **'Data exported! ✅'**
  String get exportedMsg;

  /// No description provided for @syncedMsg.
  ///
  /// In en, this message translates to:
  /// **'Data synced! ☁️'**
  String get syncedMsg;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'DANGER ZONE'**
  String get dangerZone;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearAllDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Delete all water intake history'**
  String get clearAllDataDesc;

  /// No description provided for @clearedMsg.
  ///
  /// In en, this message translates to:
  /// **'🗑️ All data cleared!'**
  String get clearedMsg;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Water Balance v1.0.0'**
  String get appVersion;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'Made with love for hydration 💧'**
  String get madeWith;

  /// No description provided for @min30.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get min30;

  /// No description provided for @hour1.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get hour1;

  /// No description provided for @hours15.
  ///
  /// In en, this message translates to:
  /// **'1.5 hours'**
  String get hours15;

  /// No description provided for @hours2.
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get hours2;

  /// No description provided for @hours3.
  ///
  /// In en, this message translates to:
  /// **'3 hours'**
  String get hours3;

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streakLabel;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(int count);

  /// No description provided for @avgDay.
  ///
  /// In en, this message translates to:
  /// **'Avg/day'**
  String get avgDay;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get done;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a reset link'**
  String get resetPasswordDesc;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Reset email sent! Check your inbox.'**
  String get resetEmailSent;

  /// No description provided for @resetEmailError.
  ///
  /// In en, this message translates to:
  /// **'Could not send reset email. Check the address.'**
  String get resetEmailError;

  /// No description provided for @clearDataConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data?'**
  String get clearDataConfirmTitle;

  /// No description provided for @clearDataConfirmMsg.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your water intake history. This cannot be undone.'**
  String get clearDataConfirmMsg;

  /// No description provided for @customReminders.
  ///
  /// In en, this message translates to:
  /// **'Custom Reminders'**
  String get customReminders;

  /// No description provided for @customRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Add specific daily reminder times'**
  String get customRemindersDesc;

  /// No description provided for @addCustomTime.
  ///
  /// In en, this message translates to:
  /// **'Add time'**
  String get addCustomTime;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
