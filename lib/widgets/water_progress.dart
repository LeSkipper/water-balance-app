import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/units.dart';

class WaterProgress extends StatelessWidget {
  final int current;
  final int goal;
  final String unit;

  const WaterProgress({super.key, required this.current, required this.goal, this.unit = 'ml'});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final percentage = (current / goal).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: percentage),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (_, value, __) => CustomPaint(
                  size: const Size(220, 220),
                  painter: _RingPainter(progress: value, ringBgColor: c.ringBg),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: current),
                    duration: const Duration(milliseconds: 800),
                    builder: (_, value, __) => Text(
                      formatAmount(value, unit),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: c.textDark,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  Text(
                    'of ${formatAmount(goal, unit)} ${unitLabel(unit)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: c.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          c.sky.withOpacity(0.15),
                          c.indigo.withOpacity(0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${(percentage * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: c.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color ringBgColor;
  _RingPainter({required this.progress, required this.ringBgColor});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    const strokeWidth = 12.0;
    final radius = (size.width / 2) - strokeWidth / 2;
    const startAngle = -pi / 2;

    // Background ring
    final bgPaint = Paint()
      ..color = ringBgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), radius, bgPaint);

    if (progress <= 0) return;

    // Gradient progress ring
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);
    final gradient = const SweepGradient(
      startAngle: 0,
      endAngle: pi * 2,
      colors: [Color(0xFF38BDF8), Color(0xFF3B82F6), Color(0xFF6366F1), Color(0xFF38BDF8)],
      stops: [0.0, 0.33, 0.66, 1.0],
    ).createShader(rect);

    final fgPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      startAngle,
      2 * pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress || old.ringBgColor != ringBgColor;
}
