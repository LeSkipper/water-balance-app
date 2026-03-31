import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class QuickAddButtons extends StatelessWidget {
  final void Function(int amount) onAdd;

  const QuickAddButtons({super.key, required this.onAdd});

  static const _presetAmounts = [100, 200, 330, 500];
  static const _presetIcons = [Icons.water_drop, Icons.local_drink, Icons.coffee, Icons.wine_bar];
  static const _presetColors = [
    [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
    [Color(0xFF60A5FA), Color(0xFF3B82F6)],
    [Color(0xFF818CF8), Color(0xFF6366F1)],
    [Color(0xFFA78BFA), Color(0xFF8B5CF6)],
  ];

  void _showCustomDialog(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;
    final ctrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(color: c.bgCard, borderRadius: const BorderRadius.vertical(top: Radius.circular(28))),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: c.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              Text(l.customAmount, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: c.textDark)),
              const SizedBox(height: 4),
              Text(l.enterAmountMl, style: TextStyle(fontSize: 13, color: c.textMuted)),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: c.inputBg, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
                child: TextField(
                  controller: ctrl, autofocus: true, keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.textDark),
                  decoration: InputDecoration(
                    border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    hintText: '0', hintStyle: TextStyle(color: c.textFaint, fontSize: 22, fontWeight: FontWeight.w700),
                    suffixText: l.ml, suffixStyle: TextStyle(color: c.textMuted, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: [50, 150, 250, 400, 750, 1000].map((preset) => GestureDetector(
                  onTap: () => ctrl.text = '$preset',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: c.segmentBg, borderRadius: BorderRadius.circular(12)),
                    child: Text('$preset', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textMid)),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  final amount = int.tryParse(ctrl.text);
                  if (amount != null && amount > 0 && amount <= 5000) {
                    Navigator.pop(context);
                    onAdd(amount);
                  }
                },
                child: Container(
                  width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: AppTheme.primaryButtonDecoration,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.add_rounded, color: Colors.white, size: 20), const SizedBox(width: 8),
                    Text(l.add, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: List.generate(_presetAmounts.length, (i) {
            final amount = _presetAmounts[i];
            final colors = _presetColors[i];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
                child: _QuickAddButton(
                  amount: amount,
                  icon: _presetIcons[i],
                  colors: colors,
                  onTap: () => onAdd(amount),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showCustomDialog(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: c.bgCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: c.border)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.tune_rounded, size: 18, color: c.textMuted), const SizedBox(width: 8),
              Text(l.customAmount, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: c.textMuted)),
            ]),
          ),
        ),
      ],
    );
  }
}

class _QuickAddButton extends StatefulWidget {
  final int amount;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;
  const _QuickAddButton({required this.amount, required this.icon, required this.colors, required this.onTap});

  @override
  State<_QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<_QuickAddButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween(begin: 1.0, end: 0.92).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _onTap() async {
    await _ctrl.forward();
    await _ctrl.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: widget.colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: widget.colors[0].withOpacity(0.35), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(widget.icon, color: Colors.white, size: 22),
            const SizedBox(height: 6),
            Text('${widget.amount} ${l.ml}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
          ]),
        ),
      ),
    );
  }
}
