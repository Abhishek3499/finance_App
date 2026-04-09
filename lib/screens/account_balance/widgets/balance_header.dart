import 'package:flutter/material.dart';

class BalanceHeader extends StatelessWidget {
  const BalanceHeader({super.key});

  static const Color darkTeal = Color(0xFF003D33);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 26),
      child: Column(
        children: [
          Row(
            children: [
              _HeaderButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.maybePop(context),
              ),
              const Expanded(
                child: Text(
                  'Account Balance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const _HeaderButton(icon: Icons.more_horiz_rounded),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE6FFF8),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$7,783.00',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: darkTeal.withOpacity(0.16),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: _HeaderStat(
                    label: 'Income',
                    amount: '\$4,250.00',
                    icon: Icons.south_west_rounded,
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: VerticalDivider(
                    color: Colors.white24,
                    thickness: 1,
                    width: 24,
                  ),
                ),
                Expanded(
                  child: _HeaderStat(
                    label: 'Expenses',
                    amount: '\$1,187.40',
                    icon: Icons.north_east_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  final String label;
  final String amount;
  final IconData icon;

  const _HeaderStat({
    required this.label,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.16),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFE6FFF8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
