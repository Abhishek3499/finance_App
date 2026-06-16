import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String type;
  final String iconPath;
  final Color iconBgColor;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.iconPath,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpense = amount.startsWith('-');

    return Container(
      margin: const EdgeInsets.only(
        bottom: 22,
      ), // Thoda space badhaya as per SS
      child: Row(
        children: [
          // 🔵 Icon Container
          Container(
            height: 55, // Size adjusted to match SS
            width: 55,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(20), // More rounded as per SS
            ),
            child: Center(child: Image.asset(iconPath, height: 28)),
          ),

          const SizedBox(width: 14),

          // 📝 Title + Subtitle Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF007BFF), // Blue subtext as per SS
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 05),
          // 🔹 First Divider (Before Type)
          Container(height: 35, width: 1.5, color: const Color(0xFF00D09E)),
          const SizedBox(width: 10),
          // 🏷️ Category/Type Section
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                type,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
          ),

          // 🔹 Second Divider (Before Amount)
          const SizedBox(width: 15),
          Container(height: 35, width: 1.5, color: const Color(0xFF00D09E)),

          // 📊 Amount Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isExpense
                        ? const Color(0xFF007BFF) // Blue for expense as per SS
                        : Colors.black,
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
