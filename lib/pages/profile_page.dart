import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  late TextEditingController _nameCtrl, _weightCtrl, _heightCtrl, _ageCtrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = context.read<AppProvider>().user;
    _nameCtrl = TextEditingController(text: user.name);
    _weightCtrl = TextEditingController(text: user.weight.toStringAsFixed(0));
    _heightCtrl = TextEditingController(text: user.height.toStringAsFixed(0));
    _ageCtrl = TextEditingController(text: user.age.toString());
  }

  @override
  void dispose() { _nameCtrl.dispose(); _weightCtrl.dispose(); _heightCtrl.dispose(); _ageCtrl.dispose(); super.dispose(); }

  void _save(AppProvider provider) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    provider.updateProfile(provider.user.copyWith(name: _nameCtrl.text, weight: double.tryParse(_weightCtrl.text) ?? provider.user.weight, height: double.tryParse(_heightCtrl.text) ?? provider.user.height, age: int.tryParse(_ageCtrl.text) ?? provider.user.age));
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.profileUpdated), backgroundColor: c.success, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))));
  }

  Future<void> _pickAvatar(AppProvider provider) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512, imageQuality: 85);
    if (picked == null || !mounted) return;
    final dir = await getApplicationDocumentsDirectory();
    final oldPath = provider.user.avatar;
    final fileName = 'avatar_${provider.user.id ?? 'user'}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await File(picked.path).copy('${dir.path}/$fileName');
    if (oldPath.isNotEmpty) {
      final old = File(oldPath);
      if (await old.exists()) await old.delete();
      await FileImage(old).evict();
    }
    provider.updateProfile(provider.user.copyWith(avatar: saved.path));
  }

  void _cancel(AppProvider provider) {
    final user = provider.user;
    _nameCtrl.text = user.name; _weightCtrl.text = user.weight.toStringAsFixed(0);
    _heightCtrl.text = user.height.toStringAsFixed(0); _ageCtrl.text = user.age.toString();
    setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final initials = user.name.split(' ').map((n) => n.isNotEmpty ? n[0] : '').join().toUpperCase();
    final memberDays = DateTime.now().difference(DateTime.tryParse(user.joinDate) ?? DateTime.now()).inDays;

    return Container(
      decoration: BoxDecoration(gradient: c.bgGradient),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(l.profile, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: c.textDark, letterSpacing: -0.5)),
              if (!_isEditing)
                _iconBtn(icon: Icons.edit_rounded, onTap: () => setState(() => _isEditing = true))
              else
                Row(children: [
                  _iconBtn(icon: Icons.close_rounded, color: const Color(0xFFF87171), onTap: () => _cancel(provider)),
                  const SizedBox(width: 8),
                  _gradientBtn(icon: Icons.check_rounded, onTap: () => _save(provider)),
                ]),
            ]),
            const SizedBox(height: 20),
            Column(children: [
              GestureDetector(
                onTap: () => _pickAvatar(provider),
                child: Stack(
                  children: [
                    Container(
                      width: 82, height: 82,
                      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF6366F1)]), shape: BoxShape.circle, boxShadow: [BoxShadow(color: c.primary.withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 6))]),
                      child: user.avatar.isNotEmpty && File(user.avatar).existsSync()
                          ? ClipOval(child: Image.file(File(user.avatar), width: 82, height: 82, fit: BoxFit.cover))
                          : Center(child: Text(initials, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white))),
                    ),
                    Positioned(
                      right: 0, bottom: 0,
                      child: Container(
                        width: 26, height: 26,
                        decoration: BoxDecoration(gradient: c.primaryGradient, shape: BoxShape.circle, border: Border.all(color: c.bgCard, width: 2)),
                        child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (_isEditing)
                Container(
                  decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.border)),
                  child: TextField(controller: _nameCtrl, textAlign: TextAlign.center, style: TextStyle(color: c.textDark, fontSize: 16, fontWeight: FontWeight.w600), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10))),
                )
              else
                Text(user.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: c.textDark)),
              const SizedBox(height: 4),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.mail_outline_rounded, size: 13, color: c.textFaint), const SizedBox(width: 4), Text(user.email, style: TextStyle(fontSize: 12, color: c.textMuted))]),
              const SizedBox(height: 3),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.calendar_month_outlined, size: 13, color: c.textFaint), const SizedBox(width: 4), Text(l.memberFor(memberDays), style: TextStyle(fontSize: 12, color: c.textMuted))]),
            ]),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.3,
              children: [
                _statCard(icon: Icons.water_drop_rounded, label: l.totalLogged, value: '${(provider.totalWaterLogged / 1000).toStringAsFixed(1)}L', color: c.primary),
                _statCard(icon: Icons.my_location_rounded, label: l.goalsHit, value: '${provider.totalDaysActive > 0 ? ((provider.totalGoalsHit / provider.totalDaysActive) * 100).round() : 0}%', color: const Color(0xFF10B981)),
                _statCard(icon: Icons.local_fire_department_rounded, label: l.bestStreak, value: '${provider.bestStreak} d', color: const Color(0xFFF97316)),
                _statCard(icon: Icons.military_tech_rounded, label: l.achievementsLabel, value: '${_unlockedAchievements(provider)}/6', color: const Color(0xFF8B5CF6)),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16), decoration: AppTheme.cardDecorationOf(context),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.bodyInfo, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: c.textMuted)),
                const SizedBox(height: 12),
                Row(children: [
                  _bodyCard(l.weight, '${user.weight.toStringAsFixed(0)} kg', Icons.monitor_weight_outlined, c.isDark ? const Color(0xFF1E3A5F) : const Color(0xFFEFF6FF), const Color(0xFF3B82F6), _isEditing ? _weightCtrl : null),
                  const SizedBox(width: 10),
                  _bodyCard(l.height, '${user.height.toStringAsFixed(0)} cm', Icons.straighten_rounded, c.isDark ? const Color(0xFF1A3A2A) : const Color(0xFFECFDF5), const Color(0xFF10B981), _isEditing ? _heightCtrl : null),
                  const SizedBox(width: 10),
                  _bodyCard(l.age, '${user.age} yrs', Icons.person_outline_rounded, c.isDark ? const Color(0xFF2D1F5E) : const Color(0xFFF5F3FF), const Color(0xFF8B5CF6), _isEditing ? _ageCtrl : null),
                ]),
              ]),
            ),
            const SizedBox(height: 14),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () { provider.logout(); context.go('/login'); },
              child: Container(
                width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: c.dangerZoneBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.dangerZoneBorder)),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 18), const SizedBox(width: 8), Text(l.signOut, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 15, fontWeight: FontWeight.w600))]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  int _unlockedAchievements(AppProvider p) {
    int count = 0;
    if (p.totalWaterLogged > 0) count++;
    if (p.bestStreak >= 7) count++;
    if (p.totalGoalsHit >= 7) count++;
    if (p.bestStreak >= 30) count++;
    if (p.totalWaterLogged >= 100000) count++;
    if (p.totalWaterLogged >= 500000) count++;
    return count;
  }

  Widget _statCard({required IconData icon, required String label, required String value, required Color color}) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.all(12), decoration: AppTheme.cardDecorationOf(context),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: c.iconBg, shape: BoxShape.circle, border: Border.all(color: c.border)), child: Icon(icon, color: color, size: 17)),
        const SizedBox(width: 10),
        Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: c.textDark), overflow: TextOverflow.ellipsis),
          Text(label, style: TextStyle(fontSize: 10, color: c.textFaint), overflow: TextOverflow.ellipsis),
        ])),
      ]),
    );
  }

  Widget _iconBtn({required IconData icon, required VoidCallback onTap, Color? color}) {
    final c = context.colors;
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: c.bgCard.withOpacity(0.85), borderRadius: BorderRadius.circular(12), border: Border.all(color: c.border)), child: Icon(icon, size: 20, color: color ?? c.textLight)));
  }

  Widget _gradientBtn({required IconData icon, required VoidCallback onTap}) {
    final c = context.colors;
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(gradient: c.primaryGradient, borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 20, color: Colors.white)));
  }

  Widget _bodyCard(String label, String value, IconData icon, Color bg, Color iconColor, TextEditingController? ctrl) {
    final c = context.colors;
    return Expanded(child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: iconColor, size: 18), const SizedBox(height: 6),
        if (ctrl != null)
          TextField(controller: ctrl, textAlign: TextAlign.center, keyboardType: TextInputType.number, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: c.textDark), decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero))
        else
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: c.textDark)),
        Text(label, style: TextStyle(fontSize: 9, color: c.textFaint)),
      ]),
    ));
  }
}
