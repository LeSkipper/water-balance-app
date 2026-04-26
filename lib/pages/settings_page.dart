import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../utils/units.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showSnack(BuildContext context, String msg, {bool isError = false}) {
    final c = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating, backgroundColor: isError ? c.danger : c.success, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))));
  }

  Future<void> _pickCustomTime(BuildContext context, AppProvider provider) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      final current = List<String>.from(provider.settings.customTimes);
      if (!current.contains(formatted)) {
        current.add(formatted);
        current.sort();
        provider.updateSettings(provider.settings.copyWith(customTimes: current));
      }
    }
  }

  Future<void> _pickTime(BuildContext context, AppProvider provider, bool isWakeUp) async {
    final settings = provider.settings;
    final timeStr = isWakeUp ? settings.wakeUpTime : settings.bedTime;
    final parts = timeStr.split(':');
    final initial = TimeOfDay(hour: int.tryParse(parts[0]) ?? (isWakeUp ? 7 : 23), minute: int.tryParse(parts[1]) ?? 0);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null && context.mounted) {
      final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      provider.updateSettings(isWakeUp
          ? provider.settings.copyWith(wakeUpTime: formatted)
          : provider.settings.copyWith(bedTime: formatted));
    }
  }


  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    final provider = context.watch<AppProvider>();
    final settings = provider.settings;
    void upd(AppSettings s) => provider.updateSettings(s);

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(l.settings, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
            Text(l.settingsSubtitle, style: TextStyle(fontSize: 14, color: c.textMuted)),
            const SizedBox(height: 20),
            // Hydration Goal
            _section(context, [
              Column(children: [
                Text(l.hydrationGoal, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _circleBtn(context, icon: Icons.remove_rounded, onTap: () => upd(settings.copyWith(goal: (settings.goal - 250).clamp(500, 5000)))),
                  const SizedBox(width: 20),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(formatAmount(settings.goal, settings.unit), style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: c.textDark)),
                    Text(unitLabel(settings.unit), style: TextStyle(fontSize: 13, color: c.textMuted)),
                  ]),
                  const SizedBox(width: 20),
                  _circleBtn(context, icon: Icons.add_rounded, onTap: () => upd(settings.copyWith(goal: (settings.goal + 250).clamp(500, 5000)))),
                ]),
                const SizedBox(height: 14),
                Row(children: [1500, 2000, 2500, 3000].map((preset) {
                  final isSelected = settings.goal == preset;
                  return Expanded(child: Padding(
                    padding: EdgeInsets.only(left: preset == 1500 ? 0 : 8),
                    child: GestureDetector(
                      onTap: () => upd(settings.copyWith(goal: preset)),
                      child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(gradient: isSelected ? c.primaryGradient : null, color: isSelected ? null : c.segmentBg, borderRadius: BorderRadius.circular(14), boxShadow: isSelected ? [BoxShadow(color: c.primary.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 3))] : null),
                        child: Center(child: Text(settings.unit == 'oz' ? '${formatAmount(preset, 'oz')}oz' : '${preset / 1000}L', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : c.textLight))),
                      ),
                    ),
                  ));
                }).toList()),
              ]),
            ]),
            const SizedBox(height: 12),
            // Measurement
            _section(context, [
              _row(context, icon: Icons.water_drop_rounded, iconColor: c.primary, label: l.unitLabel, desc: l.unitDesc,
                trailing: _segmented(context, options: const ['ml', 'oz'], selected: settings.unit, onSelect: (v) => upd(settings.copyWith(unit: v)))),
            ], title: l.measurement),
            const SizedBox(height: 12),
            // Reminders
            _section(context, [
              _row(context, icon: settings.reminderEnabled ? Icons.notifications_rounded : Icons.notifications_off_rounded, iconColor: const Color(0xFFF97316), label: l.remindersLabel, desc: l.remindersDesc, trailing: _toggle(context, settings.reminderEnabled, (v) => upd(settings.copyWith(reminderEnabled: v)))),
              if (settings.reminderEnabled) ...[
                Divider(color: c.border, height: 1),
                _row(context, icon: Icons.access_time_rounded, iconColor: const Color(0xFF0EA5E9), label: l.interval, desc: l.intervalDesc,
                  trailing: _dropdown(context, value: settings.reminderInterval, items: {30: l.min30, 60: l.hour1, 90: l.hours15, 120: l.hours2, 180: l.hours3}, onChanged: (v) => upd(settings.copyWith(reminderInterval: v!)))),
                Divider(color: c.border, height: 1),
                GestureDetector(onTap: () => _pickTime(context, provider, true), child: _row(context, icon: Icons.wb_sunny_rounded, iconColor: const Color(0xFFFBBF24), label: l.wakeUp, desc: settings.wakeUpTime, trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint))),
                Divider(color: c.border, height: 1),
                GestureDetector(onTap: () => _pickTime(context, provider, false), child: _row(context, icon: Icons.bedtime_rounded, iconColor: const Color(0xFF8B5CF6), label: l.bedTime, desc: settings.bedTime, trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint))),
                Divider(color: c.border, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: c.iconBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: c.border)), child: Icon(Icons.alarm_add_rounded, color: const Color(0xFFEC4899), size: 18)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(l.customReminders, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: c.textDark)),
                        Text(l.customRemindersDesc, style: TextStyle(fontSize: 10, color: c.textFaint)),
                      ])),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _pickCustomTime(context, provider),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(gradient: c.primaryGradient, borderRadius: BorderRadius.circular(12)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.add_rounded, color: Colors.white, size: 14),
                            const SizedBox(width: 4),
                            Text(l.addCustomTime, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ),
                    ]),
                    if (settings.customTimes.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 8, children: settings.customTimes.map((time) =>
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.schedule_rounded, size: 12, color: c.primary),
                            const SizedBox(width: 5),
                            Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textDark)),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                final updated = List<String>.from(settings.customTimes)..remove(time);
                                upd(settings.copyWith(customTimes: updated));
                              },
                              child: Icon(Icons.close_rounded, size: 14, color: c.textFaint),
                            ),
                          ]),
                        ),
                      ).toList()),
                    ],
                  ]),
                ),
              ],
            ], title: l.reminders),
            const SizedBox(height: 12),
            // Sounds
            _section(context, [
              _row(context, icon: settings.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded, iconColor: const Color(0xFF10B981), label: l.soundEffects, desc: l.soundEffectsDesc, trailing: _toggle(context, settings.soundEnabled, (v) => upd(settings.copyWith(soundEnabled: v)))),
              Divider(color: c.border, height: 1),
              _row(context, icon: Icons.phone_android_rounded, iconColor: const Color(0xFF8B5CF6), label: l.vibration, desc: l.vibrationDesc, trailing: _toggle(context, settings.vibrationEnabled, (v) => upd(settings.copyWith(vibrationEnabled: v)))),
            ], title: l.soundsHaptics),
            const SizedBox(height: 12),
            // Appearance
            _section(context, [
              _row(context, icon: Icons.palette_rounded, iconColor: const Color(0xFFEC4899), label: l.themeLabel,
                trailing: _segmented(context, options: const ['light', 'dark', 'auto'], selected: settings.theme, onSelect: (v) => upd(settings.copyWith(theme: v)), icons: const [Icons.wb_sunny_rounded, Icons.bedtime_rounded, Icons.computer_rounded])),
              Divider(color: c.border, height: 1),
              _row(context, icon: Icons.language_rounded, iconColor: c.primary, label: l.languageLabel, desc: settings.language,
                trailing: _dropdown(context, value: settings.language, items: const {'English': 'English', 'Spanish': 'Español', 'French': 'Français', 'German': 'Deutsch', 'Russian': 'Русский'}, onChanged: (v) => upd(settings.copyWith(language: v!)))),
            ], title: l.appearance),
            const SizedBox(height: 12),
            // Data
            _section(context, [
              GestureDetector(
                onTap: () async {
                  final p = context.read<AppProvider>();
                  await p.refreshData();
                  if (context.mounted) _showSnack(context, l.syncedMsg);
                },
                child: _row(context, icon: Icons.sync_rounded, iconColor: const Color(0xFF10B981), label: l.syncData, desc: l.syncDataDesc, trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint)),
              ),
            ], title: l.dataSection),
            const SizedBox(height: 12),
            // Danger zone
            Container(padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: c.dangerZoneBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.dangerZoneBorder)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.dangerZone, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFF87171))),
                GestureDetector(
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: c.bgCard,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: Text(l.clearDataConfirmTitle, style: TextStyle(color: c.textDark, fontWeight: FontWeight.w700)),
                      content: Text(l.clearDataConfirmMsg, style: TextStyle(color: c.textMuted, fontSize: 14)),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel, style: TextStyle(color: c.textLight))),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: Text(l.confirm, style: const TextStyle(color: Color(0xFFF87171), fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true && context.mounted) {
                    await context.read<AppProvider>().clearAllData();
                    if (context.mounted) _showSnack(context, l.clearedMsg);
                  }
                },
                child: _row(context, icon: Icons.delete_rounded, iconColor: const Color(0xFFF87171), label: l.clearAllData, desc: l.clearAllDataDesc, trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFFCA5A5))),
              ),
              ]),
            ),
            const SizedBox(height: 20),
            Center(child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.info_outline_rounded, size: 12, color: c.textFaint), const SizedBox(width: 4), Text(l.appVersion, style: TextStyle(fontSize: 10, color: c.textFaint))]),
              const SizedBox(height: 3),
              Text(l.madeWith, style: TextStyle(fontSize: 10, color: c.textFaint)),
            ])),
          ]),
        ),
      ),
    );
  }

  Widget _section(BuildContext context, List<Widget> children, {String? title}) {
    final c = context.colors;
    return Container(padding: const EdgeInsets.all(16), decoration: AppTheme.cardDecorationOf(context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (title != null) ...[Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)), const SizedBox(height: 4)],
        ...children,
      ]),
    );
  }

  Widget _row(BuildContext context, {required IconData icon, required Color iconColor, required String label, String? desc, required Widget trailing}) {
    final c = context.colors;
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: c.iconBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: c.border)), child: Icon(icon, color: iconColor, size: 18)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: c.textDark)),
        if (desc != null) Text(desc, style: TextStyle(fontSize: 10, color: c.textFaint), overflow: TextOverflow.ellipsis),
      ])),
      const SizedBox(width: 12),
      trailing,
    ]));
  }

  Widget _toggle(BuildContext context, bool value, void Function(bool) onChanged) {
    final c = context.colors;
    return GestureDetector(onTap: () => onChanged(!value), child: AnimatedContainer(
      duration: const Duration(milliseconds: 250), width: 48, height: 28,
      decoration: BoxDecoration(gradient: value ? c.primaryGradient : null, color: value ? null : c.toggleOff, borderRadius: BorderRadius.circular(14)),
      child: Stack(children: [AnimatedPositioned(duration: const Duration(milliseconds: 250), curve: Curves.easeInOut, left: value ? 22 : 3, top: 3, child: Container(width: 22, height: 22, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)])))]),
    ));
  }

  Widget _segmented(BuildContext context, {required List<String> options, required String selected, required void Function(String) onSelect, List<IconData>? icons}) {
    final c = context.colors;
    return Container(padding: const EdgeInsets.all(3), decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: options.asMap().entries.map((e) {
        final isSelected = e.value == selected;
        return GestureDetector(onTap: () => onSelect(e.value), child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: isSelected ? c.segmentSelectedBg : Colors.transparent, borderRadius: BorderRadius.circular(10), boxShadow: isSelected ? [const BoxShadow(color: Color(0x11000000), blurRadius: 4)] : null),
          child: icons != null ? Icon(icons[e.key], size: 16, color: isSelected ? c.textDark : c.textFaint) : Text(e.value.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? c.textDark : c.textFaint)),
        ));
      }).toList()),
    );
  }

  Widget _dropdown<T>(BuildContext context, {required T value, required Map<T, String> items, required void Function(T?) onChanged}) {
    final c = context.colors;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(12)),
      child: DropdownButton<T>(value: value, items: items.entries.map((e) => DropdownMenuItem<T>(value: e.key, child: Text(e.value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textDark)))).toList(),
        onChanged: onChanged, underline: const SizedBox(), isDense: true, dropdownColor: c.bgCard, style: TextStyle(fontSize: 12, color: c.textDark), icon: Icon(Icons.expand_more_rounded, size: 16, color: c.textFaint)),
    );
  }

  Widget _circleBtn(BuildContext context, {required IconData icon, required VoidCallback onTap}) {
    final c = context.colors;
    return GestureDetector(onTap: onTap, child: Container(width: 40, height: 40,
      decoration: BoxDecoration(gradient: LinearGradient(colors: c.isDark ? [const Color(0xFF334155), const Color(0xFF475569)] : [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)], begin: Alignment.topCenter, end: Alignment.bottomCenter), shape: BoxShape.circle),
      child: Icon(icon, color: c.textMid, size: 20)));
  }
}
