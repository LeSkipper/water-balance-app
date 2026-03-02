import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

final _monthNames = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

final _achievements = [
  _Achievement(icon: Icons.emoji_events_rounded, title: 'First Sip', desc: 'Log your first glass', unlocked: true, colors: [Color(0xFFFBBF24), Color(0xFFF97316)]),
  _Achievement(icon: Icons.local_fire_department_rounded, title: '7-Day Streak', desc: 'Reach goal 7 days in a row', unlocked: true, colors: [Color(0xFFF87171), Color(0xFFFB7185)]),
  _Achievement(icon: Icons.my_location_rounded, title: 'Perfect Week', desc: 'Hit 100% every day for a week', unlocked: true, colors: [Color(0xFF34D399), Color(0xFF10B981)]),
  _Achievement(icon: Icons.bolt_rounded, title: '30-Day Warrior', desc: 'Maintain a 30-day streak', unlocked: false, colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)]),
  _Achievement(icon: Icons.military_tech_rounded, title: 'Hydration Master', desc: 'Drink 100L total', unlocked: false, colors: [Color(0xFF60A5FA), Color(0xFF06B6D4)]),
  _Achievement(icon: Icons.water_drop_rounded, title: 'Ocean Drinker', desc: 'Drink 500L total', unlocked: false, colors: [Color(0xFF38BDF8), Color(0xFF3B82F6)]),
];

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int _currentMonth = DateTime.now().month - 1;

  late List<Map<String, int>> _monthData;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _monthData = List.generate(28, (i) => {'day': i + 1, 'amount': rng.nextInt(1500) + 800});
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final settings = context.watch<AppProvider>().settings;
    final goal = settings.goal;

    final avgIntake = (_monthData.map((d) => d['amount']!).reduce((a, b) => a + b) / _monthData.length).round();
    final goalDays = _monthData.where((d) => d['amount']! >= goal).length;
    final totalIntake = _monthData.map((d) => d['amount']!).reduce((a, b) => a + b);
    final bestDay = _monthData.map((d) => d['amount']!).reduce((a, b) => a > b ? a : b);
    final maxAmount = bestDay;

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Statistics', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
              Text('Track your hydration progress', style: TextStyle(fontSize: 14, color: c.textMuted)),
              const SizedBox(height: 20),
              // Summary cards
              _buildSummaryCards(c, avgIntake, goalDays, totalIntake, bestDay),
              const SizedBox(height: 16),
              // Monthly chart
              _buildMonthlyChart(c, goal, maxAmount, goalDays),
              const SizedBox(height: 16),
              // Achievements
              Text('ACHIEVEMENTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
              const SizedBox(height: 12),
              _buildAchievements(c),
              const SizedBox(height: 16),
              // Tip
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: c.isDark ? [const Color(0xFF1E293B), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFEEF2FF)]),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: c.isDark ? const Color(0xFF334155) : const Color(0xFFBFDBFE)),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hydration Tip', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.primary)),
                  const SizedBox(height: 6),
                  Text(
                    'Drinking water before meals can help with digestion and may reduce calorie intake. Try having a glass 30 minutes before eating.',
                    style: TextStyle(fontSize: 14, color: c.textMid),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(AppColorsData c, int avg, int goalDays, int total, int best) {
    final items = [
      {'icon': Icons.trending_up_rounded, 'label': 'Avg. Daily', 'value': '$avg ml', 'color': const Color(0xFF10B981), 'bg': c.isDark ? [const Color(0xFF1A3A2A), const Color(0xFF15332A)] : [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)]},
      {'icon': Icons.my_location_rounded, 'label': 'Goals Hit', 'value': '$goalDays/28', 'color': const Color(0xFF3B82F6), 'bg': c.isDark ? [const Color(0xFF1E2D4A), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFE0E7FF)]},
      {'icon': Icons.water_drop_rounded, 'label': 'Total', 'value': '${(total / 1000).toStringAsFixed(1)}L', 'color': const Color(0xFF0EA5E9), 'bg': c.isDark ? [const Color(0xFF153040), const Color(0xFF1A3545)] : [const Color(0xFFF0F9FF), const Color(0xFFE0F2FE)]},
      {'icon': Icons.military_tech_rounded, 'label': 'Best Day', 'value': '$best ml', 'color': const Color(0xFF8B5CF6), 'bg': c.isDark ? [const Color(0xFF2D1F5E), const Color(0xFF251B50)] : [const Color(0xFFF5F3FF), const Color(0xFFEDE9FE)]},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: items.map((item) {
        final colors = item['bg'] as List<Color>;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
            const SizedBox(height: 8),
            Text(item['value'] as String, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.textDark)),
            Text(item['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: c.textMuted)),
          ]),
        );
      }).toList(),
    );
  }

  Widget _buildMonthlyChart(AppColorsData c, int goal, int maxAmount, int goalDays) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecorationOf(context),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.calendar_month_rounded, color: c.primary, size: 18),
              const SizedBox(width: 8),
              Text('Monthly Overview', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textDark)),
            ]),
            Row(children: [
              GestureDetector(
                onTap: () => setState(() => _currentMonth = (_currentMonth > 0 ? _currentMonth - 1 : 0)),
                child: Icon(Icons.chevron_left_rounded, color: c.textMuted, size: 22),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 84,
                child: Center(
                  child: Text('${_monthNames[_currentMonth]} 2026',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMid)),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => setState(() => _currentMonth = (_currentMonth < 11 ? _currentMonth + 1 : 11)),
                child: Icon(Icons.chevron_right_rounded, color: c.textMuted, size: 22),
              ),
            ]),
          ]),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _monthData.map((item) {
                final amount = item['amount']!;
                final frac = (amount / maxAmount).clamp(0.04, 1.0);
                final metGoal = amount >= goal;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: FractionallySizedBox(
                      heightFactor: frac,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: metGoal
                                ? [const Color(0xFF34D399), const Color(0xFF6EE7B7)]
                                : c.isDark
                                    ? [const Color(0xFF334155), const Color(0xFF475569)]
                                    : [const Color(0xFFBFDBFE), const Color(0xFFDBEAFE)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            for (final d in [1, 7, 14, 21, 28])
              Text('$d', style: TextStyle(fontSize: 9, color: c.textFaint)),
          ]),
          const SizedBox(height: 10),
          Divider(color: c.borderLight, height: 1),
          const SizedBox(height: 10),
          Row(children: [
            Container(width: 14, height: 2, decoration: BoxDecoration(color: const Color(0xFF34D399), borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 6),
            Text('Goal reached ($goalDays days)', style: TextStyle(fontSize: 10, color: c.textMuted)),
          ]),
        ],
      ),
    );
  }

  Widget _buildAchievements(AppColorsData c) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.85,
      children: _achievements.map((ach) {
        return Opacity(
          opacity: ach.unlocked ? 1.0 : 0.45,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: c.bgCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ach.unlocked ? c.border : (c.isDark ? const Color(0xFF334155) : const Color(0xFFF3F4F6))),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: ach.unlocked ? LinearGradient(colors: ach.colors) : null,
                  color: ach.unlocked ? null : (c.isDark ? const Color(0xFF475569) : const Color(0xFFE5E7EB)),
                  shape: BoxShape.circle,
                ),
                child: Icon(ach.icon, color: ach.unlocked ? Colors.white : (c.isDark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF)), size: 20),
              ),
              const SizedBox(height: 8),
              Text(ach.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: c.textDark)),
              const SizedBox(height: 3),
              Text(ach.desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.textFaint, height: 1.3)),
            ]),
          ),
        );
      }).toList(),
    );
  }
}

class _Achievement {
  final IconData icon;
  final String title;
  final String desc;
  final bool unlocked;
  final List<Color> colors;
  const _Achievement({required this.icon, required this.title, required this.desc, required this.unlocked, required this.colors});
}
