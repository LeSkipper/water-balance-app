// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Water Balance';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signInSubtitle => 'Connectez-vous pour continuer';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get or => 'OU';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get debugLogin => 'Debug Login';

  @override
  String get noAccount => 'Pas de compte ? ';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ? ';

  @override
  String get back => 'Retour';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get createAccountSubtitle => 'Commencez votre parcours hydratation';

  @override
  String get fullName => 'Nom complet';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get continueBtn => 'Continuer';

  @override
  String get passwordWeak => 'Faible';

  @override
  String get passwordMedium => 'Moyen';

  @override
  String get passwordStrong => 'Fort';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs';

  @override
  String get passwordsMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get accountCreated => 'Compte créé ! À votre santé ! 💧';

  @override
  String get aboutYou => 'À propos de vous';

  @override
  String get aboutYouSubtitle => 'Personnalisons votre objectif';

  @override
  String get weightKg => 'POIDS (KG)';

  @override
  String get activityLevel => 'NIVEAU D\'ACTIVITÉ';

  @override
  String get activityLow => 'Faible';

  @override
  String get activityModerate => 'Modéré';

  @override
  String get activityHigh => 'Élevé';

  @override
  String get wakeUp => 'Réveil';

  @override
  String get wakeUpLabel => 'RÉVEIL';

  @override
  String get bedTime => 'Coucher';

  @override
  String get bedTimeLabel => 'COUCHER';

  @override
  String get recommendedGoal => 'Objectif quotidien recommandé';

  @override
  String get recommendedGoalSubtitle => 'Basé sur votre poids et activité';

  @override
  String hiUser(String name) {
    return 'Bonjour, $name';
  }

  @override
  String get stayHydrated => 'Restez hydraté, restez en santé';

  @override
  String get quickAdd => 'AJOUT RAPIDE';

  @override
  String get todayLog => 'JOURNAL DU JOUR';

  @override
  String entry(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'entrées',
      one: 'entrée',
    );
    return '$_temp0';
  }

  @override
  String get dailyReset => '🔄 Consommation journalière réinitialisée';

  @override
  String addedMl(int amount) {
    return '💧 +$amount ml ajoutés';
  }

  @override
  String get goalReachedMsg => '🎉 Vous avez atteint votre objectif !';

  @override
  String get entryRemoved => 'Entrée supprimée';

  @override
  String ofGoal(int goal) {
    return 'sur $goal ml';
  }

  @override
  String get noWaterToday => 'Aucune consommation aujourd\'hui';

  @override
  String get tapToStart => 'Appuyez sur les boutons ci-dessus pour commencer';

  @override
  String get customAmount => 'Quantité personnalisée';

  @override
  String get enterAmountMl => 'Entrez une quantité en ml';

  @override
  String get add => 'Ajouter';

  @override
  String get profile => 'Profil';

  @override
  String get profileUpdated => 'Profil mis à jour !';

  @override
  String get totalLogged => 'Total enregistré';

  @override
  String get goalsHit => 'Objectifs atteints';

  @override
  String get bestStreak => 'Meilleure série';

  @override
  String get achievementsLabel => 'Succès';

  @override
  String get bodyInfo => 'INFORMATIONS CORPORELLES';

  @override
  String get weight => 'Poids';

  @override
  String get height => 'Taille';

  @override
  String get age => 'Âge';

  @override
  String memberFor(int days) {
    return 'Membre depuis $days jours';
  }

  @override
  String get privacySecurity => 'Confidentialité et sécurité';

  @override
  String get helpSupport => 'Aide et support';

  @override
  String get rateApp => 'Noter l\'application';

  @override
  String get statistics => 'Statistiques';

  @override
  String get statsSubtitle => 'Suivez votre progrès';

  @override
  String get avgDaily => 'Moy. quotidienne';

  @override
  String get total => 'Total';

  @override
  String get bestDay => 'Meilleur jour';

  @override
  String get monthlyOverview => 'Vue mensuelle';

  @override
  String goalReachedDays(int days) {
    return 'Objectif atteint ($days jours)';
  }

  @override
  String get goalReached => 'Objectif atteint';

  @override
  String get belowGoal => 'En dessous';

  @override
  String get achievements => 'SUCCÈS';

  @override
  String get hydrationTip => 'Conseil hydratation';

  @override
  String get hydrationTipText =>
      'Boire de l\'eau avant les repas favorise la digestion et peut réduire l\'appétit. Essayez de boire un verre 30 minutes avant de manger.';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get ach1Title => 'Première gorgée';

  @override
  String get ach1Desc => 'Enregistrez votre premier verre';

  @override
  String get ach2Title => 'Série de 7 jours';

  @override
  String get ach2Desc => 'Atteignez l\'objectif 7 jours de suite';

  @override
  String get ach3Title => 'Semaine parfaite';

  @override
  String get ach3Desc => '100% chaque jour de la semaine';

  @override
  String get ach4Title => 'Guerrier des 30 jours';

  @override
  String get ach4Desc => 'Maintenez une série de 30 jours';

  @override
  String get ach5Title => 'Maître de l\'hydratation';

  @override
  String get ach5Desc => 'Buvez 100L en tout';

  @override
  String get ach6Title => 'Buveur océanique';

  @override
  String get ach6Desc => 'Buvez 500L en tout';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsSubtitle => 'Personnalisez votre expérience';

  @override
  String get hydrationGoal => 'OBJECTIF D\'HYDRATATION';

  @override
  String get ml => 'ml';

  @override
  String get measurement => 'MESURE';

  @override
  String get unitLabel => 'Unité';

  @override
  String get unitDesc => 'Unité de volume';

  @override
  String get reminders => 'RAPPELS';

  @override
  String get remindersLabel => 'Rappels';

  @override
  String get remindersDesc => 'Recevoir des notifications';

  @override
  String get interval => 'Intervalle';

  @override
  String get intervalDesc => 'Fréquence des rappels';

  @override
  String get soundsHaptics => 'SONS ET HAPTIQUE';

  @override
  String get soundEffects => 'Effets sonores';

  @override
  String get soundEffectsDesc => 'Jouer des sons';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Retour haptique';

  @override
  String get appearance => 'APPARENCE';

  @override
  String get themeLabel => 'Thème';

  @override
  String get languageLabel => 'Langue';

  @override
  String get themeLight => 'light';

  @override
  String get themeDark => 'dark';

  @override
  String get themeAuto => 'auto';

  @override
  String get dataSection => 'DONNÉES';

  @override
  String get exportData => 'Exporter les données';

  @override
  String get exportDataDesc => 'Télécharger l\'historique en CSV';

  @override
  String get syncData => 'Synchroniser';

  @override
  String get syncDataDesc => 'Synchroniser avec le cloud';

  @override
  String get exportedMsg => 'Données exportées ! ✅';

  @override
  String get syncedMsg => 'Synchronisé ! ☁️';

  @override
  String get dangerZone => 'ZONE DANGER';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get clearAllDataDesc => 'Supprimer tout l\'historique';

  @override
  String get clearedMsg => '🗑️ Toutes les données effacées !';

  @override
  String get appVersion => 'Water Balance v1.0.0';

  @override
  String get madeWith => 'Fait avec amour pour l\'hydratation 💧';

  @override
  String get min30 => '30 min';

  @override
  String get hour1 => '1 heure';

  @override
  String get hours15 => '1.5 heure';

  @override
  String get hours2 => '2 heures';

  @override
  String get hours3 => '3 heures';

  @override
  String get streakLabel => 'Série';

  @override
  String streakDays(int count) {
    return '$count jours';
  }

  @override
  String get avgDay => 'Moy/jour';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get done => 'Fait !';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordDesc => 'Entrez votre email pour recevoir le lien';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String get resetEmailSent => 'Email envoyé ! Vérifiez votre boîte.';

  @override
  String get resetEmailError => 'Impossible d\'envoyer l\'email.';

  @override
  String get clearDataConfirmTitle => 'Effacer toutes les données ?';

  @override
  String get clearDataConfirmMsg =>
      'Tout l\'historique de consommation d\'eau sera supprimé définitivement.';

  @override
  String get customReminders => 'Rappels personnalisés';

  @override
  String get customRemindersDesc =>
      'Ajoutez des horaires de rappel spécifiques';

  @override
  String get addCustomTime => 'Ajouter une heure';
}
