import 'package:flutter/material.dart';
import '../models/intake_entry.dart';
import '../theme/app_theme.dart';
import '../l10n/app_localizations.dart';

class IntakeHistory extends StatelessWidget {
  final List<IntakeEntry> entries;
  final void Function(String id) onRemove;

  const IntakeHistory({super.key, required this.entries, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;

    if (entries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(children: [
          Icon(Icons.water_drop_outlined, size: 48, color: c.textFaint.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text(l.noWaterToday, style: TextStyle(fontSize: 14, color: c.textFaint)),
          const SizedBox(height: 4),
          Text(l.tapToStart, style: TextStyle(fontSize: 12, color: c.textFaint.withOpacity(0.7))),
        ]),
      );
    }

    return Column(children: entries.map((entry) => Padding(padding: const EdgeInsets.only(bottom: 8), child: _EntryCard(entry: entry, onRemove: onRemove))).toList());
  }
}

class _EntryCard extends StatefulWidget {
  final IntakeEntry entry;
  final void Function(String id) onRemove;
  const _EntryCard({required this.entry, required this.onRemove});

  @override
  State<_EntryCard> createState() => _EntryCardState();
}

class _EntryCardState extends State<_EntryCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(-0.2, 0), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: c.bgCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: c.border)),
          child: Row(children: [
            Container(width: 38, height: 38, decoration: BoxDecoration(gradient: LinearGradient(colors: c.isDark ? [const Color(0xFF1E2D4A), const Color(0xFF1E2340)] : [const Color(0xFFE0F2FE), const Color(0xFFDBEAFE)], begin: Alignment.topLeft, end: Alignment.bottomRight), shape: BoxShape.circle), child: Icon(Icons.water_drop, size: 18, color: c.primary)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${widget.entry.amount} ${l.ml}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: c.textDark)),
              Text(widget.entry.time, style: TextStyle(fontSize: 12, color: c.textMuted)),
            ])),
            GestureDetector(onTap: () => widget.onRemove(widget.entry.id), child: Container(padding: const EdgeInsets.all(8), child: Icon(Icons.delete_outline_rounded, size: 18, color: c.textFaint))),
          ]),
        ),
      ),
    );
  }
}
