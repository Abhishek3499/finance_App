import 'dart:math' as math;
import 'package:finace_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({super.key});

  static const Color primaryGreen = Color(0xFF00D09E);
  static const Color ink = Color(0xFF0F172A);
  static const Color muted = Color(0xFF475569);
  static const Color accentBlue = Color(0xFF6C8CFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ChartSection.ink,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Savings on Goals',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ChartSection.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  '30%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              const _GoalPieChart(),
              const SizedBox(width: 22),
              Expanded(
                child: Column(
                  children: const [
                    _DetailRow(
                      iconPath: Assets.revenue,
                      title: 'Revenue Last Week',
                      amount: '-\$4,000.00',
                      amountColor: ChartSection.ink,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Divider(color: Colors.white54, height: 1),
                    ),
                    _DetailRow(
                      iconPath: Assets.food,
                      title: 'Food Last Week',
                      amount: '-\$100.00',
                      amountColor: ChartSection.accentBlue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalPieChart extends StatelessWidget {
  const _GoalPieChart();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: Column(
        children: [
          SizedBox(
            height: 96,
            width: 96,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size.square(96),
                  painter: _PieChartPainter(),
                ),
                Container(
                  height: 54,
                  width: 54,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.car,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Savings\nOn Goals',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: ChartSection.ink,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String amount;
  final Color amountColor;

  const _DetailRow({
    required this.iconPath,
    required this.title,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              height: 22,
              width: 22,
              color: ChartSection.ink,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ChartSection.muted,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final center = size.center(Offset.zero);

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    ringPaint.color = Colors.white.withValues(alpha: 0.35);
    canvas.drawArc(rect.deflate(6), -math.pi / 2, math.pi * 2, false, ringPaint);

    ringPaint.color = Colors.white;
    canvas.drawArc(rect.deflate(6), -math.pi / 2, math.pi * 0.95, false, ringPaint);

    ringPaint.color = const Color(0xFF6C8CFF);
    canvas.drawArc(
      rect.deflate(6),
      -math.pi / 2 + math.pi * 1.08,
      math.pi * 0.52,
      false,
      ringPaint,
    );

    final dotPaint = Paint()..color = const Color(0xFF6C8CFF);
    final dotOffset = Offset(
      center.dx + math.cos(math.pi * 1.63) * 38,
      center.dy + math.sin(math.pi * 1.63) * 38,
    );
    canvas.drawCircle(dotOffset, 4.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
