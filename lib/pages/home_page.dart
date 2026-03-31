import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/app_provider.dart';
import '../models/intake_entry.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../widgets/water_progress.dart';
import '../widgets/quick_add_buttons.dart';
import '../widgets/intake_history.dart';
import '../widgets/water_stats.dart';
import '../widgets/weekly_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$hour:$m $period';
  }

  String _todayDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _showSnack(BuildContext context, String msg, {bool isSuccess = false}) {
    final c = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isSuccess ? c.success : c.primary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final settings = provider.settings;
    final entries = provider.entries;
    final goal = settings.goal;
    final currentIntake = provider.currentIntake;
    final firstName = user.name.split(' ').first;

    final weeklyData = provider.weeklyData;
    final weekAvg = () {
      final completedDays = weeklyData.where((d) => (d['amount'] as int) > 0).toList();
      if (completedDays.isEmpty) return 0;
      return (completedDays.map((d) => d['amount'] as int).reduce((a, b) => a + b) / completedDays.length).round();
    }();
    final todayPercent = ((currentIntake / goal) * 100).round();

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(gradient: c.primaryGradient, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: c.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),
                      child: const Icon(Icons.water_drop, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.hiUser(firstName), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.textDark)),
                      Text(l.stayHydrated, style: TextStyle(fontSize: 11, color: c.textMuted)),
                    ])),
                    _iconButton(context: context, icon: Icons.refresh_rounded, onTap: () {
                      provider.resetEntries();
                      _showSnack(context, l.dailyReset);
                    }),
                    const SizedBox(width: 8),
                    _iconButton(context: context, icon: Icons.settings_rounded, onTap: () => context.go('/settings')),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: WaterProgress(current: currentIntake, goal: goal)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l.quickAdd, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
                  const SizedBox(height: 10),
                  QuickAddButtons(onAdd: (amount) {
                    final entry = IntakeEntry(id: const Uuid().v4(), userId: user.id ?? '0', amount: amount, time: _formatTime(DateTime.now()), date: _todayDate());
                    final prev = provider.currentIntake;
                    provider.addEntry(entry);
                    final newTotal = prev + amount;
                    if (newTotal >= goal && prev < goal) {
                      _showSnack(context, l.goalReachedMsg, isSuccess: true);
                    } else {
                      _showSnack(context, l.addedMl(amount));
                    }
                  }),
                ]),
              ),
              const SizedBox(height: 16),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: WaterStats(streak: provider.streak, weekAverage: weekAvg, todayPercent: todayPercent)),
              const SizedBox(height: 16),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: WeeklyChart(data: weeklyData, goal: goal)),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(l.todayLog, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
                  if (entries.isNotEmpty) Text(l.entry(entries.length), style: TextStyle(fontSize: 11, color: c.textFaint)),
                ]),
              ),
              const SizedBox(height: 10),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: IntakeHistory(entries: entries, onRemove: (id) {
                provider.removeEntry(id);
                _showSnack(context, l.entryRemoved);
              })),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({required BuildContext context, required IconData icon, required VoidCallback onTap}) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: c.bgCard.withOpacity(0.85), borderRadius: BorderRadius.circular(12), border: Border.all(color: c.border)),
        child: Icon(icon, size: 20, color: c.textLight),
      ),
    );
  }
}
