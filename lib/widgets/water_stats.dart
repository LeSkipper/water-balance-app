import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WaterStats extends StatelessWidget {
  final int streak;
  final int weekAverage;
  final int todayPercent;

  const WaterStats({
    super.key,
    required this.streak,
    required this.weekAverage,
    required this.todayPercent,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    final stats = [
      _Stat(
        icon: Icons.local_fire_department_rounded,
        label: 'Streak',
        value: '$streak days',
        iconColor: const Color(0xFFF97316),
        gradientColors: c.isDark
            ? [const Color(0xFF3B2A1A), const Color(0xFF332210)]
            : [const Color(0xFFFFF7ED), const Color(0xFFFEF3C7)],
      ),
      _Stat(
        icon: Icons.trending_up_rounded,
        label: 'Avg/day',
        value: '$weekAverage ml',
        iconColor: const Color(0xFF10B981),
        gradientColors: c.isDark
            ? [const Color(0xFF1A3A2A), const Color(0xFF153320)]
            : [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)],
      ),
      _Stat(
        icon: Icons.emoji_events_rounded,
        label: 'Today',
        value: todayPercent >= 100 ? 'Done!' : '$todayPercent%',
        iconColor: c.primary,
        gradientColors: c.isDark
            ? [const Color(0xFF1E2D4A), const Color(0xFF1E2340)]
            : [const Color(0xFFEFF6FF), const Color(0xFFE0E7FF)],
      ),
    ];

    return Row(
      children: stats.asMap().entries.map((e) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: e.key == 0 ? 0 : 10),
            child: _StatCard(stat: e.value),
          ),
        );
      }).toList(),
    );
  }
}

class _Stat {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final List<Color> gradientColors;
  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.gradientColors,
  });
}

class _StatCard extends StatelessWidget {
  final _Stat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: stat.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(stat.icon, color: stat.iconColor, size: 22),
          const SizedBox(height: 6),
          Text(
            stat.value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: c.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: c.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
