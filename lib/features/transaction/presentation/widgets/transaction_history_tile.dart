import 'package:flutter/material.dart';

class TransactionHistoryTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String type;
  final dynamic icon; // Can be String (asset path) or IconData
  final Color iconBgColor;

  const TransactionHistoryTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.icon,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpense = amount.startsWith('-');

    // Resolve the icon widget
    Widget iconWidget;
    if (icon is String) {
      iconWidget = Image.asset(
        icon as String,
        height: 24,
        width: 24,
        color: Colors.white,
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        color: Colors.white,
        size: 24,
      );
    } else {
      iconWidget = const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // 🔵 Circle Icon Container
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: iconWidget),
          ),

          const SizedBox(width: 14),

          // 📝 Title + Subtitle Section
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003D33),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF007BFF), // Blue subtext as per design
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 First Teal Divider
          Container(
            height: 32,
            width: 1.2,
            color: const Color(0xFF00D09E).withValues(alpha: 0.5),
          ),
          const SizedBox(width: 10),

          // 🏷️ Category/Type Section
          Expanded(
            flex: 3,
            child: Text(
              type,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // 🔹 Second Teal Divider
          Container(
            height: 32,
            width: 1.2,
            color: const Color(0xFF00D09E).withValues(alpha: 0.5),
          ),
          const SizedBox(width: 12),

          // 📊 Amount Section
          Expanded(
            flex: 4,
            child: Text(
              amount,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isExpense
                    ? const Color(0xFF007BFF) // Blue for expenses as per design
                    : const Color(0xFF003D33), // Dark teal for income
              ),
            ),
          ),
        ],
      ),
    );
  }
}
