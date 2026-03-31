// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Water Balance';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signInSubtitle => 'Inicia sesión para continuar';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get or => 'O';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get debugLogin => 'Debug Login';

  @override
  String get noAccount => '¿No tienes cuenta? ';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? ';

  @override
  String get back => 'Volver';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get createAccountSubtitle => 'Comienza tu viaje de hidratación hoy';

  @override
  String get fullName => 'Nombre completo';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get continueBtn => 'Continuar';

  @override
  String get passwordWeak => 'Débil';

  @override
  String get passwordMedium => 'Media';

  @override
  String get passwordStrong => 'Fuerte';

  @override
  String get fillAllFields => 'Por favor completa todos los campos';

  @override
  String get passwordsMismatch => 'Las contraseñas no coinciden';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get accountCreated => '¡Cuenta creada! ¡A hidratarse! 💧';

  @override
  String get aboutYou => 'Sobre ti';

  @override
  String get aboutYouSubtitle => 'Personalicemos tu meta de agua';

  @override
  String get weightKg => 'PESO (KG)';

  @override
  String get activityLevel => 'NIVEL DE ACTIVIDAD';

  @override
  String get activityLow => 'Bajo';

  @override
  String get activityModerate => 'Moderado';

  @override
  String get activityHigh => 'Alto';

  @override
  String get wakeUp => 'Despertar';

  @override
  String get wakeUpLabel => 'DESPERTAR';

  @override
  String get bedTime => 'Dormir';

  @override
  String get bedTimeLabel => 'DORMIR';

  @override
  String get recommendedGoal => 'Meta diaria recomendada';

  @override
  String get recommendedGoalSubtitle => 'Según tu peso y nivel de actividad';

  @override
  String hiUser(String name) {
    return 'Hola, $name';
  }

  @override
  String get stayHydrated => 'Hidrátate, mantente saludable';

  @override
  String get quickAdd => 'AÑADIR RÁPIDO';

  @override
  String get todayLog => 'REGISTRO DE HOY';

  @override
  String entry(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'entradas',
      one: 'entrada',
    );
    return '$_temp0';
  }

  @override
  String get dailyReset => '🔄 Ingesta diaria reiniciada';

  @override
  String addedMl(int amount) {
    return '💧 +$amount ml añadidos';
  }

  @override
  String get goalReachedMsg => '🎉 ¡Alcanzaste tu meta diaria!';

  @override
  String get entryRemoved => 'Entrada eliminada';

  @override
  String ofGoal(int goal) {
    return 'de $goal ml';
  }

  @override
  String get noWaterToday => 'Sin registros hoy';

  @override
  String get tapToStart => 'Toca los botones de arriba para comenzar';

  @override
  String get customAmount => 'Cantidad personalizada';

  @override
  String get enterAmountMl => 'Ingresa cualquier cantidad en ml';

  @override
  String get add => 'Añadir';

  @override
  String get profile => 'Perfil';

  @override
  String get profileUpdated => '¡Perfil actualizado!';

  @override
  String get totalLogged => 'Total registrado';

  @override
  String get goalsHit => 'Metas alcanzadas';

  @override
  String get bestStreak => 'Mejor racha';

  @override
  String get achievementsLabel => 'Logros';

  @override
  String get bodyInfo => 'INFORMACIÓN CORPORAL';

  @override
  String get weight => 'Peso';

  @override
  String get height => 'Altura';

  @override
  String get age => 'Edad';

  @override
  String memberFor(int days) {
    return 'Miembro hace $days días';
  }

  @override
  String get privacySecurity => 'Privacidad y seguridad';

  @override
  String get helpSupport => 'Ayuda y soporte';

  @override
  String get rateApp => 'Calificar la app';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get statsSubtitle => 'Sigue tu progreso de hidratación';

  @override
  String get avgDaily => 'Promedio diario';

  @override
  String get total => 'Total';

  @override
  String get bestDay => 'Mejor día';

  @override
  String get monthlyOverview => 'Resumen mensual';

  @override
  String goalReachedDays(int days) {
    return 'Meta alcanzada ($days días)';
  }

  @override
  String get goalReached => 'Meta alcanzada';

  @override
  String get belowGoal => 'Bajo la meta';

  @override
  String get achievements => 'LOGROS';

  @override
  String get hydrationTip => 'Consejo de hidratación';

  @override
  String get hydrationTipText =>
      'Beber agua antes de las comidas ayuda a la digestión y puede reducir el apetito. Intenta tomar un vaso 30 minutos antes de comer.';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get ach1Title => 'Primer sorbo';

  @override
  String get ach1Desc => 'Registra tu primer vaso';

  @override
  String get ach2Title => 'Racha de 7 días';

  @override
  String get ach2Desc => 'Alcanza la meta 7 días seguidos';

  @override
  String get ach3Title => 'Semana perfecta';

  @override
  String get ach3Desc => '100% cada día de la semana';

  @override
  String get ach4Title => 'Guerrero de 30 días';

  @override
  String get ach4Desc => 'Mantén una racha de 30 días';

  @override
  String get ach5Title => 'Maestro de la hidratación';

  @override
  String get ach5Desc => 'Bebe 100L en total';

  @override
  String get ach6Title => 'Bebedor oceánico';

  @override
  String get ach6Desc => 'Bebe 500L en total';

  @override
  String get settings => 'Configuración';

  @override
  String get settingsSubtitle => 'Personaliza tu experiencia';

  @override
  String get hydrationGoal => 'META DE HIDRATACIÓN';

  @override
  String get ml => 'ml';

  @override
  String get measurement => 'MEDICIÓN';

  @override
  String get unitLabel => 'Unidad';

  @override
  String get unitDesc => 'Unidad de volumen';

  @override
  String get reminders => 'RECORDATORIOS';

  @override
  String get remindersLabel => 'Recordatorios';

  @override
  String get remindersDesc => 'Recibe notificaciones para beber agua';

  @override
  String get interval => 'Intervalo';

  @override
  String get intervalDesc => 'Frecuencia de recordatorios';

  @override
  String get soundsHaptics => 'SONIDOS Y HÁPTICA';

  @override
  String get soundEffects => 'Efectos de sonido';

  @override
  String get soundEffectsDesc => 'Reproducir sonidos';

  @override
  String get vibration => 'Vibración';

  @override
  String get vibrationDesc => 'Retroalimentación háptica';

  @override
  String get appearance => 'APARIENCIA';

  @override
  String get themeLabel => 'Tema';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get themeLight => 'light';

  @override
  String get themeDark => 'dark';

  @override
  String get themeAuto => 'auto';

  @override
  String get dataSection => 'DATOS';

  @override
  String get exportData => 'Exportar datos';

  @override
  String get exportDataDesc => 'Descargar historial en CSV';

  @override
  String get syncData => 'Sincronizar datos';

  @override
  String get syncDataDesc => 'Sincronizar con la nube';

  @override
  String get exportedMsg => '¡Datos exportados! ✅';

  @override
  String get syncedMsg => '¡Sincronizado! ☁️';

  @override
  String get dangerZone => 'ZONA DE PELIGRO';

  @override
  String get clearAllData => 'Borrar todos los datos';

  @override
  String get clearAllDataDesc => 'Eliminar todo el historial';

  @override
  String get clearedMsg => '🗑️ ¡Todos los datos borrados!';

  @override
  String get appVersion => 'Water Balance v1.0.0';

  @override
  String get madeWith => 'Hecho con amor por la hidratación 💧';

  @override
  String get min30 => '30 min';

  @override
  String get hour1 => '1 hora';

  @override
  String get hours15 => '1.5 horas';

  @override
  String get hours2 => '2 horas';

  @override
  String get hours3 => '3 horas';

  @override
  String get streakLabel => 'Racha';

  @override
  String streakDays(int count) {
    return '$count días';
  }

  @override
  String get avgDay => 'Prom/día';

  @override
  String get today => 'Hoy';

  @override
  String get done => '¡Listo!';
}
