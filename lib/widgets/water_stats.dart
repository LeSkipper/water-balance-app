import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/units.dart';

class WaterStats extends StatelessWidget {
  final int streak;
  final int weekAverage;
  final int todayPercent;
  final String unit;

  const WaterStats({super.key, required this.streak, required this.weekAverage, required this.todayPercent, this.unit = 'ml'});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;

    final stats = [
      (Icons.local_fire_department_rounded, l.streakLabel, l.streakDays(streak), const Color(0xFFF97316), c.isDark ? [const Color(0xFF3B2A1A), const Color(0xFF332210)] : [const Color(0xFFFFF7ED), const Color(0xFFFEF3C7)]),
      (Icons.trending_up_rounded, l.avgDay, '${formatAmount(weekAverage, unit)} ${unitLabel(unit)}', const Color(0xFF10B981), c.isDark ? [const Color(0xFF1A3A2A), const Color(0xFF153320)] : [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)]),
      (Icons.emoji_events_rounded, l.today, todayPercent >= 100 ? l.done : '$todayPercent%', c.primary, c.isDark ? [const Color(0xFF1E2D4A), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFE0E7FF)]),
    ];

    return Row(children: stats.asMap().entries.map((e) => Expanded(child: Padding(
      padding: EdgeInsets.only(left: e.key == 0 ? 0 : 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(gradient: LinearGradient(colors: e.value.$5 as List<Color>, begin: Alignment.topCenter, end: Alignment.bottomCenter), borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Icon(e.value.$1, color: e.value.$4, size: 22), const SizedBox(height: 6),
          Text(e.value.$3, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: c.textDark)),
          const SizedBox(height: 2),
          Text(e.value.$2, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: c.textMuted)),
        ]),
      ),
    ))).toList());
  }
}
