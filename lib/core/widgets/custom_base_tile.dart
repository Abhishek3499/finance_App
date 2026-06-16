import 'package:flutter/material.dart';

class CustomBaseTile extends StatelessWidget {
  final Widget icon;
  final Color iconBgColor;
  final Widget content;
  final VoidCallback? onTap;

  const CustomBaseTile({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: icon,
            ),
            const SizedBox(width: 16),
            
            // Content Area
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
