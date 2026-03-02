import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuickAddButtons extends StatelessWidget {
  final void Function(int amount) onAdd;

  const QuickAddButtons({super.key, required this.onAdd});

  static const _options = [
    _Option(amount: 100, label: '100 ml', icon: Icons.water_drop, colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)]),
    _Option(amount: 200, label: '200 ml', icon: Icons.local_drink, colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)]),
    _Option(amount: 330, label: '330 ml', icon: Icons.coffee, colors: [Color(0xFF818CF8), Color(0xFF6366F1)]),
    _Option(amount: 500, label: '500 ml', icon: Icons.wine_bar, colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _options.asMap().entries.map((entry) {
        final i = entry.key;
        final opt = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 8),
            child: _QuickAddButton(option: opt, onTap: () => onAdd(opt.amount)),
          ),
        );
      }).toList(),
    );
  }
}

class _Option {
  final int amount;
  final String label;
  final IconData icon;
  final List<Color> colors;
  const _Option({required this.amount, required this.label, required this.icon, required this.colors});
}

class _QuickAddButton extends StatefulWidget {
  final _Option option;
  final VoidCallback onTap;
  const _QuickAddButton({required this.option, required this.onTap});

  @override
  State<_QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<_QuickAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _ctrl.forward();
    await _ctrl.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.option.colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.option.colors[0].withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.option.icon, color: Colors.white, size: 22),
              const SizedBox(height: 6),
              Text(
                widget.option.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
