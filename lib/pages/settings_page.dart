import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/app_settings.dart';
import '../theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showSnack(BuildContext context, String msg) {
    final c = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: c.success,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final provider = context.watch<AppProvider>();
    final settings = provider.settings;

    void upd(AppSettings s) => provider.updateSettings(s);

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
              Text('Customize your experience', style: TextStyle(fontSize: 14, color: c.textMuted)),
              const SizedBox(height: 20),

              // --- HYDRATION GOAL ---
              _section(context, [
                Column(children: [
                  Text('HYDRATION GOAL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
                  const SizedBox(height: 14),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _circleBtn(context, icon: Icons.remove_rounded, onTap: () {
                      final newGoal = (settings.goal - 250).clamp(500, 5000);
                      upd(settings.copyWith(goal: newGoal));
                    }),
                    const SizedBox(width: 20),
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('${settings.goal}', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: c.textDark)),
                      Text('ml', style: TextStyle(fontSize: 13, color: c.textMuted)),
                    ]),
                    const SizedBox(width: 20),
                    _circleBtn(context, icon: Icons.add_rounded, onTap: () {
                      final newGoal = (settings.goal + 250).clamp(500, 5000);
                      upd(settings.copyWith(goal: newGoal));
                    }),
                  ]),
                  const SizedBox(height: 14),
                  Row(children: [1500, 2000, 2500, 3000].map((preset) {
                    final isSelected = settings.goal == preset;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: preset == 1500 ? 0 : 8),
                        child: GestureDetector(
                          onTap: () => upd(settings.copyWith(goal: preset)),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              gradient: isSelected ? c.primaryGradient : null,
                              color: isSelected ? null : c.segmentBg,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: isSelected ? [BoxShadow(color: c.primary.withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 3))] : null,
                            ),
                            child: Center(child: Text('${preset / 1000}L', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : c.textLight))),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                ]),
              ]),

              const SizedBox(height: 12),

              // --- MEASUREMENT ---
              _section(context, [
                _settingRow(
                  context,
                  icon: Icons.water_drop_rounded,
                  iconColor: c.primary,
                  label: 'Unit',
                  desc: 'Volume measurement unit',
                  trailing: _segmented(
                    context,
                    options: const ['ml', 'oz'],
                    selected: settings.unit,
                    onSelect: (v) => upd(settings.copyWith(unit: v)),
                  ),
                ),
              ], title: 'MEASUREMENT'),

              const SizedBox(height: 12),

              // --- REMINDERS ---
              _section(context, [
                _settingRow(
                  context,
                  icon: settings.reminderEnabled ? Icons.notifications_rounded : Icons.notifications_off_rounded,
                  iconColor: const Color(0xFFF97316),
                  label: 'Reminders',
                  desc: 'Get notified to drink water',
                  trailing: _toggle(context, settings.reminderEnabled, (v) => upd(settings.copyWith(reminderEnabled: v))),
                ),
                if (settings.reminderEnabled) ...[
                  Divider(color: c.border, height: 1),
                  _settingRow(
                    context,
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFF0EA5E9),
                    label: 'Interval',
                    desc: 'How often to remind',
                    trailing: _dropdown(
                      context,
                      value: settings.reminderInterval,
                      items: const {30: '30 min', 60: '1 hour', 90: '1.5 hours', 120: '2 hours', 180: '3 hours'},
                      onChanged: (v) => upd(settings.copyWith(reminderInterval: v!)),
                    ),
                  ),
                  Divider(color: c.border, height: 1),
                  _settingRow(
                    context,
                    icon: Icons.wb_sunny_rounded,
                    iconColor: const Color(0xFFFBBF24),
                    label: 'Wake Up',
                    desc: settings.wakeUpTime,
                    trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint),
                  ),
                  Divider(color: c.border, height: 1),
                  _settingRow(
                    context,
                    icon: Icons.bedtime_rounded,
                    iconColor: const Color(0xFF8B5CF6),
                    label: 'Bed Time',
                    desc: settings.bedTime,
                    trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint),
                  ),
                ],
              ], title: 'REMINDERS'),

              const SizedBox(height: 12),

              // --- SOUNDS & HAPTICS ---
              _section(context, [
                _settingRow(
                  context,
                  icon: settings.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                  iconColor: const Color(0xFF10B981),
                  label: 'Sound Effects',
                  desc: 'Play sounds on actions',
                  trailing: _toggle(context, settings.soundEnabled, (v) => upd(settings.copyWith(soundEnabled: v))),
                ),
                Divider(color: c.border, height: 1),
                _settingRow(
                  context,
                  icon: Icons.phone_android_rounded,
                  iconColor: const Color(0xFF8B5CF6),
                  label: 'Vibration',
                  desc: 'Haptic feedback',
                  trailing: _toggle(context, settings.vibrationEnabled, (v) => upd(settings.copyWith(vibrationEnabled: v))),
                ),
              ], title: 'SOUNDS & HAPTICS'),

              const SizedBox(height: 12),

              // --- APPEARANCE ---
              _section(context, [
                _settingRow(
                  context,
                  icon: Icons.palette_rounded,
                  iconColor: const Color(0xFFEC4899),
                  label: 'Theme',
                  trailing: _segmented(
                    context,
                    options: const ['light', 'dark', 'auto'],
                    selected: settings.theme,
                    onSelect: (v) => upd(settings.copyWith(theme: v)),
                    icons: const [Icons.wb_sunny_rounded, Icons.bedtime_rounded, Icons.computer_rounded],
                  ),
                ),
                Divider(color: c.border, height: 1),
                _settingRow(
                  context,
                  icon: Icons.language_rounded,
                  iconColor: c.primary,
                  label: 'Language',
                  desc: settings.language,
                  trailing: _dropdown(
                    context,
                    value: settings.language,
                    items: const {'English': 'English', 'Spanish': 'Spanish', 'French': 'French', 'German': 'German', 'Russian': 'Русский'},
                    onChanged: (v) => upd(settings.copyWith(language: v!)),
                  ),
                ),
              ], title: 'APPEARANCE'),

              const SizedBox(height: 12),

              // --- DATA ---
              _section(context, [
                GestureDetector(
                  onTap: () => _showSnack(context, 'Data exported! ✅'),
                  child: _settingRow(context, icon: Icons.download_rounded, iconColor: c.primary, label: 'Export Data', desc: 'Download your history as CSV', trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint)),
                ),
                Divider(color: c.border, height: 1),
                GestureDetector(
                  onTap: () => _showSnack(context, 'Data synced! ☁️'),
                  child: _settingRow(context, icon: Icons.sync_rounded, iconColor: const Color(0xFF10B981), label: 'Sync Data', desc: 'Sync with cloud storage', trailing: Icon(Icons.chevron_right_rounded, color: c.textFaint)),
                ),
              ], title: 'DATA'),

              const SizedBox(height: 12),

              // --- DANGER ZONE ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: c.dangerZoneBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: c.dangerZoneBorder),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('DANGER ZONE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFF87171))),
                  GestureDetector(
                    onTap: () => _showSnack(context, '🗑️ All data cleared!'),
                    child: _settingRow(context, icon: Icons.delete_rounded, iconColor: const Color(0xFFF87171), label: 'Clear All Data', desc: 'Delete all water intake history', trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFFCA5A5))),
                  ),
                ]),
              ),

              const SizedBox(height: 20),
              Center(child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.info_outline_rounded, size: 12, color: c.textFaint),
                  const SizedBox(width: 4),
                  Text('Water Balance v1.0.0', style: TextStyle(fontSize: 10, color: c.textFaint)),
                ]),
                const SizedBox(height: 3),
                Text('Made with love for hydration 💧', style: TextStyle(fontSize: 10, color: c.textFaint)),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(BuildContext context, List<Widget> children, {String? title}) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecorationOf(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
            const SizedBox(height: 4),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _settingRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    String? desc,
    required Widget trailing,
  }) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: c.iconBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: c.border)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: c.textDark)),
          if (desc != null) Text(desc, style: TextStyle(fontSize: 10, color: c.textFaint), overflow: TextOverflow.ellipsis),
        ])),
        const SizedBox(width: 12),
        trailing,
      ]),
    );
  }

  Widget _toggle(BuildContext context, bool value, void Function(bool) onChanged) {
    final c = context.colors;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          gradient: value ? c.primaryGradient : null,
          color: value ? null : c.toggleOff,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: value ? 22 : 3,
            top: 3,
            child: Container(width: 22, height: 22, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 4)])),
          ),
        ]),
      ),
    );
  }

  Widget _segmented(
    BuildContext context, {
    required List<String> options,
    required String selected,
    required void Function(String) onSelect,
    List<IconData>? icons,
  }) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: options.asMap().entries.map((e) {
        final isSelected = e.value == selected;
        return GestureDetector(
          onTap: () => onSelect(e.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? c.segmentSelectedBg : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isSelected ? [const BoxShadow(color: Color(0x11000000), blurRadius: 4)] : null,
            ),
            child: icons != null
                ? Icon(icons[e.key], size: 16, color: isSelected ? c.textDark : c.textFaint)
                : Text(e.value.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? c.textDark : c.textFaint)),
          ),
        );
      }).toList()),
    );
  }

  Widget _dropdown<T>(BuildContext context, {required T value, required Map<T, String> items, required void Function(T?) onChanged}) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(12)),
      child: DropdownButton<T>(
        value: value,
        items: items.entries.map((e) => DropdownMenuItem<T>(value: e.key, child: Text(e.value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textDark)))).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
        isDense: true,
        dropdownColor: c.bgCard,
        style: TextStyle(fontSize: 12, color: c.textDark),
        icon: Icon(Icons.expand_more_rounded, size: 16, color: c.textFaint),
      ),
    );
  }

  Widget _circleBtn(BuildContext context, {required IconData icon, required VoidCallback onTap}) {
    final c = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: c.isDark ? [const Color(0xFF334155), const Color(0xFF475569)] : [const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: c.textMid, size: 20),
      ),
    );
  }
}
