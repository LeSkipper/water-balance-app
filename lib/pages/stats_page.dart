import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int _currentMonth = DateTime.now().month - 1;
  late List<Map<String, int>> _monthData;

  static const _monthNames = ['January','February','March','April','May','June','July','August','September','October','November','December'];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _monthData = List.generate(28, (i) => {'day': i + 1, 'amount': rng.nextInt(1500) + 800});
  }

  List<(IconData, String Function(AppLocalizations), String Function(AppLocalizations), bool, List<Color>)> _achievements(AppLocalizations l) => [
    (Icons.emoji_events_rounded, (l) => l.ach1Title, (l) => l.ach1Desc, true, [const Color(0xFFFBBF24), const Color(0xFFF97316)]),
    (Icons.local_fire_department_rounded, (l) => l.ach2Title, (l) => l.ach2Desc, true, [const Color(0xFFF87171), const Color(0xFFFB7185)]),
    (Icons.my_location_rounded, (l) => l.ach3Title, (l) => l.ach3Desc, true, [const Color(0xFF34D399), const Color(0xFF10B981)]),
    (Icons.bolt_rounded, (l) => l.ach4Title, (l) => l.ach4Desc, false, [const Color(0xFFA78BFA), const Color(0xFF8B5CF6)]),
    (Icons.military_tech_rounded, (l) => l.ach5Title, (l) => l.ach5Desc, false, [const Color(0xFF60A5FA), const Color(0xFF06B6D4)]),
    (Icons.water_drop_rounded, (l) => l.ach6Title, (l) => l.ach6Desc, false, [const Color(0xFF38BDF8), const Color(0xFF3B82F6)]),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    final goal = context.watch<AppProvider>().settings.goal;
    final avgIntake = (_monthData.map((d) => d['amount']!).reduce((a, b) => a + b) / _monthData.length).round();
    final goalDays = _monthData.where((d) => d['amount']! >= goal).length;
    final totalIntake = _monthData.map((d) => d['amount']!).reduce((a, b) => a + b);
    final bestDay = _monthData.map((d) => d['amount']!).reduce((a, b) => a > b ? a : b);

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(l.statistics, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
            Text(l.statsSubtitle, style: TextStyle(fontSize: 14, color: c.textMuted)),
            const SizedBox(height: 20),
            _buildSummary(c, l, avgIntake, goalDays, totalIntake, bestDay),
            const SizedBox(height: 16),
            _buildMonthlyChart(c, l, goal, bestDay, goalDays),
            const SizedBox(height: 16),
            Text(l.achievements, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85,
              children: _achievements(l).map((ach) => Opacity(
                opacity: ach.$4 ? 1.0 : 0.45,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: c.bgCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: ach.$4 ? c.border : (c.isDark ? const Color(0xFF334155) : const Color(0xFFF3F4F6)))),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 40, height: 40, decoration: BoxDecoration(gradient: ach.$4 ? LinearGradient(colors: ach.$5) : null, color: ach.$4 ? null : (c.isDark ? const Color(0xFF475569) : const Color(0xFFE5E7EB)), shape: BoxShape.circle), child: Icon(ach.$1, color: ach.$4 ? Colors.white : (c.isDark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF)), size: 20)),
                    const SizedBox(height: 8),
                    Text(ach.$2(l), textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: c.textDark)),
                    const SizedBox(height: 3),
                    Text(ach.$3(l), textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.textFaint, height: 1.3)),
                  ]),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: c.isDark ? [const Color(0xFF1E293B), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFEEF2FF)]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c.isDark ? const Color(0xFF334155) : const Color(0xFFBFDBFE)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.hydrationTip, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.primary)),
                const SizedBox(height: 6),
                Text(l.hydrationTipText, style: TextStyle(fontSize: 14, color: c.textMid)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildSummary(AppColorsData c, AppLocalizations l, int avg, int goalDays, int total, int best) {
    final items = [
      (Icons.trending_up_rounded, l.avgDaily, '$avg ml', const Color(0xFF10B981), c.isDark ? [const Color(0xFF1A3A2A), const Color(0xFF15332A)] : [const Color(0xFFECFDF5), const Color(0xFFD1FAE5)]),
      (Icons.my_location_rounded, l.goalsHit, '$goalDays/28', const Color(0xFF3B82F6), c.isDark ? [const Color(0xFF1E2D4A), const Color(0xFF1E2340)] : [const Color(0xFFEFF6FF), const Color(0xFFE0E7FF)]),
      (Icons.water_drop_rounded, l.total, '${(total / 1000).toStringAsFixed(1)}L', const Color(0xFF0EA5E9), c.isDark ? [const Color(0xFF153040), const Color(0xFF1A3545)] : [const Color(0xFFF0F9FF), const Color(0xFFE0F2FE)]),
      (Icons.military_tech_rounded, l.bestDay, '$best ml', const Color(0xFF8B5CF6), c.isDark ? [const Color(0xFF2D1F5E), const Color(0xFF251B50)] : [const Color(0xFFF5F3FF), const Color(0xFFEDE9FE)]),
    ];
    return GridView.count(
      crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6,
      children: items.map((item) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(gradient: LinearGradient(colors: item.$5 as List<Color>, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(item.$1, color: item.$4, size: 20), const SizedBox(height: 8),
          Text(item.$3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.textDark)),
          Text(item.$2, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: c.textMuted)),
        ]),
      )).toList(),
    );
  }

  Widget _buildMonthlyChart(AppColorsData c, AppLocalizations l, int goal, int maxAmount, int goalDays) {
    return Container(
      padding: const EdgeInsets.all(16), decoration: AppTheme.cardDecorationOf(context),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [Icon(Icons.calendar_month_rounded, color: c.primary, size: 18), const SizedBox(width: 8), Text(l.monthlyOverview, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textDark))]),
          Row(children: [
            GestureDetector(onTap: () => setState(() => _currentMonth = (_currentMonth > 0 ? _currentMonth - 1 : 0)), child: Icon(Icons.chevron_left_rounded, color: c.textMuted, size: 22)),
            const SizedBox(width: 4),
            SizedBox(width: 84, child: Center(child: Text('${_monthNames[_currentMonth]} 2026', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMid)))),
            const SizedBox(width: 4),
            GestureDetector(onTap: () => setState(() => _currentMonth = (_currentMonth < 11 ? _currentMonth + 1 : 11)), child: Icon(Icons.chevron_right_rounded, color: c.textMuted, size: 22)),
          ]),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: _monthData.map((item) {
            final amount = item['amount']!;
            final frac = (amount / maxAmount).clamp(0.04, 1.0);
            final metGoal = amount >= goal;
            return Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 1), child: FractionallySizedBox(heightFactor: frac, alignment: Alignment.bottomCenter, child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: metGoal ? [const Color(0xFF34D399), const Color(0xFF6EE7B7)] : c.isDark ? [const Color(0xFF334155), const Color(0xFF475569)] : [const Color(0xFFBFDBFE), const Color(0xFFDBEAFE)], begin: Alignment.bottomCenter, end: Alignment.topCenter), borderRadius: BorderRadius.circular(3))))));
          }).toList()),
        ),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [for (final d in [1, 7, 14, 21, 28]) Text('$d', style: TextStyle(fontSize: 9, color: c.textFaint))]),
        const SizedBox(height: 10),
        Divider(color: c.borderLight, height: 1),
        const SizedBox(height: 10),
        Row(children: [
          Container(width: 14, height: 2, decoration: BoxDecoration(color: const Color(0xFF34D399), borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 6),
          Text(l.goalReachedDays(goalDays), style: TextStyle(fontSize: 10, color: c.textMuted)),
        ]),
      ]),
    );
  }
}
