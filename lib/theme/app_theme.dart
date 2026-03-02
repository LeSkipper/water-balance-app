import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme‑aware color tokens exposed as a [ThemeExtension].
/// Access via `AppColorsData.of(context)` or the `context.colors` extension.
class AppColorsData extends ThemeExtension<AppColorsData> {
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color indigo;
  final Color sky;

  final Color textDark;
  final Color textMid;
  final Color textLight;
  final Color textMuted;
  final Color textFaint;

  final Color border;
  final Color borderLight;
  final Color bgPage;
  final Color bgCard;

  final Color success;
  final Color danger;
  final Color warning;

  final Color inputBg;
  final Color iconBg;
  final Color segmentBg;
  final Color segmentSelectedBg;
  final Color toggleOff;
  final Color navBarBg;
  final Color ringBg;
  final Color dangerZoneBg;
  final Color dangerZoneBorder;

  final LinearGradient primaryGradient;
  final LinearGradient ringGradient;
  final LinearGradient bgGradient;

  final Brightness brightness;

  const AppColorsData({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.indigo,
    required this.sky,
    required this.textDark,
    required this.textMid,
    required this.textLight,
    required this.textMuted,
    required this.textFaint,
    required this.border,
    required this.borderLight,
    required this.bgPage,
    required this.bgCard,
    required this.success,
    required this.danger,
    required this.warning,
    required this.inputBg,
    required this.iconBg,
    required this.segmentBg,
    required this.segmentSelectedBg,
    required this.toggleOff,
    required this.navBarBg,
    required this.ringBg,
    required this.dangerZoneBg,
    required this.dangerZoneBorder,
    required this.primaryGradient,
    required this.ringGradient,
    required this.bgGradient,
    required this.brightness,
  });

  // ─── Light palette ──────────────────────────────────────────
  static const light = AppColorsData(
    primary: Color(0xFF3B82F6),
    primaryDark: Color(0xFF1D4ED8),
    primaryLight: Color(0xFF93C5FD),
    indigo: Color(0xFF6366F1),
    sky: Color(0xFF38BDF8),

    textDark: Color(0xFF1E3A5F),
    textMid: Color(0xFF4A6B8A),
    textLight: Color(0xFF6B8DB5),
    textMuted: Color(0xFF8AA8C7),
    textFaint: Color(0xFFA0B8D0),

    border: Color(0xFFE8F0FE),
    borderLight: Color(0xFFE0EEFF),
    bgPage: Color(0xFFF0F7FF),
    bgCard: Colors.white,

    success: Color(0xFF34D399),
    danger: Color(0xFFEF4444),
    warning: Color(0xFFFBBF24),

    inputBg: Colors.white,
    iconBg: Color(0xFFF8FAFC),
    segmentBg: Color(0xFFF1F5F9),
    segmentSelectedBg: Colors.white,
    toggleOff: Color(0xFFD0D8E0),
    navBarBg: Colors.white,
    ringBg: Color(0xFFE0EEFF),
    dangerZoneBg: Color(0xFFFFF1F2),
    dangerZoneBorder: Color(0xFFFFCDD2),

    primaryGradient: LinearGradient(
      colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    ringGradient: LinearGradient(
      colors: [Color(0xFF38BDF8), Color(0xFF3B82F6), Color(0xFF6366F1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    bgGradient: LinearGradient(
      colors: [Color(0xFFF0F7FF), Color(0xFFF5F9FF), Color(0xFFEEF4FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    brightness: Brightness.light,
  );

  // ─── Dark palette ───────────────────────────────────────────
  static const dark = AppColorsData(
    primary: Color(0xFF60A5FA),
    primaryDark: Color(0xFF3B82F6),
    primaryLight: Color(0xFF93C5FD),
    indigo: Color(0xFF818CF8),
    sky: Color(0xFF38BDF8),

    textDark: Color(0xFFE2E8F0),
    textMid: Color(0xFFCBD5E1),
    textLight: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    textFaint: Color(0xFF475569),

    border: Color(0xFF334155),
    borderLight: Color(0xFF1E293B),
    bgPage: Color(0xFF0F172A),
    bgCard: Color(0xFF1E293B),

    success: Color(0xFF34D399),
    danger: Color(0xFFEF4444),
    warning: Color(0xFFFBBF24),

    inputBg: Color(0xFF1E293B),
    iconBg: Color(0xFF1E293B),
    segmentBg: Color(0xFF334155),
    segmentSelectedBg: Color(0xFF475569),
    toggleOff: Color(0xFF475569),
    navBarBg: Color(0xFF1E293B),
    ringBg: Color(0xFF334155),
    dangerZoneBg: Color(0xFF3B1C1C),
    dangerZoneBorder: Color(0xFF7F1D1D),

    primaryGradient: LinearGradient(
      colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    ringGradient: LinearGradient(
      colors: [Color(0xFF38BDF8), Color(0xFF3B82F6), Color(0xFF6366F1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    bgGradient: LinearGradient(
      colors: [Color(0xFF0F172A), Color(0xFF131C2E), Color(0xFF0F172A)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    brightness: Brightness.dark,
  );

  /// Convenience accessor.
  static AppColorsData of(BuildContext context) =>
      Theme.of(context).extension<AppColorsData>() ?? light;

  bool get isDark => brightness == Brightness.dark;

  @override
  AppColorsData copyWith({Color? primary, Color? bgPage}) => this; // no‑op

  @override
  AppColorsData lerp(AppColorsData? other, double t) => t < 0.5 ? this : (other ?? this);
}

/// Shorthand extension on [BuildContext].
extension AppColorsContext on BuildContext {
  AppColorsData get colors => AppColorsData.of(this);
}

// ─── Static convenience (used where context is unavailable) ─────────
// Kept for backward‑compatibility; prefer `context.colors` in widgets.
class AppColors {
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF93C5FD);
  static const Color indigo = Color(0xFF6366F1);
  static const Color sky = Color(0xFF38BDF8);

  static const Color textDark = Color(0xFF1E3A5F);
  static const Color textMid = Color(0xFF4A6B8A);
  static const Color textLight = Color(0xFF6B8DB5);
  static const Color textMuted = Color(0xFF8AA8C7);
  static const Color textFaint = Color(0xFFA0B8D0);

  static const Color border = Color(0xFFE8F0FE);
  static const Color borderLight = Color(0xFFE0EEFF);
  static const Color bgPage = Color(0xFFF0F7FF);
  static const Color bgCard = Colors.white;

  static const Color success = Color(0xFF34D399);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFFBBF24);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient ringGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF3B82F6), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [Color(0xFFF0F7FF), Color(0xFFF5F9FF), Color(0xFFEEF4FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// ─── ThemeData builders ──────────────────────────────────────────────
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      scaffoldBackgroundColor: AppColorsData.light.bgPage,
      cardTheme: CardThemeData(
        color: AppColorsData.light.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: AppColorsData.light.border),
        ),
      ),
      extensions: const [AppColorsData.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      scaffoldBackgroundColor: AppColorsData.dark.bgPage,
      cardTheme: CardThemeData(
        color: AppColorsData.dark.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: AppColorsData.dark.border),
        ),
      ),
      extensions: const [AppColorsData.dark],
    );
  }

  // Kept for backward-compat; prefer theme-aware version below.
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      );

  static BoxDecoration cardDecorationOf(BuildContext context) {
    final c = AppColorsData.of(context);
    return BoxDecoration(
      color: c.bgCard,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: c.border),
    );
  }

  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      );
}
