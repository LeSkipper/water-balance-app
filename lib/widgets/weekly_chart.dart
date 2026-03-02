import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WeeklyChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final int goal;

  const WeeklyChart({super.key, required this.data, required this.goal});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final maxAmount = data
        .map((d) => d['amount'] as int)
        .fold(goal, (a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecorationOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: c.textDark,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                final amount = item['amount'] as int;
                final day = item['day'] as String;
                final isToday = i == data.length - 1;
                final reachedGoal = amount >= goal;
                final heightFraction = maxAmount > 0
                    ? (amount / maxAmount).clamp(0.04, 1.0)
                    : 0.04;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            heightFactor: heightFraction,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: heightFraction),
                              duration: Duration(milliseconds: 400 + i * 60),
                              curve: Curves.easeOut,
                              builder: (_, val, child) => Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: isToday
                                        ? [const Color(0xFF3B82F6), const Color(0xFF38BDF8)]
                                        : reachedGoal
                                            ? [const Color(0xFF34D399), const Color(0xFF6EE7B7)]
                                            : c.isDark
                                                ? [const Color(0xFF334155), const Color(0xFF475569)]
                                                : [const Color(0xFFBFDBFE), const Color(0xFFDBEAFE)],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          day,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                            color: isToday
                                ? c.primary
                                : c.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Divider(
            color: c.borderLight,
            height: 1,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                  width: 14, height: 2,
                  decoration: BoxDecoration(
                      color: const Color(0xFF34D399),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 6),
              Text('Goal reached',
                  style: TextStyle(fontSize: 10, color: c.textMuted)),
              const SizedBox(width: 12),
              Container(
                  width: 14, height: 2,
                  decoration: BoxDecoration(
                      color: c.isDark ? const Color(0xFF475569) : const Color(0xFFBFDBFE),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 6),
              Text('Below goal',
                  style: TextStyle(fontSize: 10, color: c.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
