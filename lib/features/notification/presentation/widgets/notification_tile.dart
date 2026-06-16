import 'package:finace_app/core/widgets/custom_base_tile.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String desc;
  final String? extraDesc;
  final String time;
  final Object icon;
  final Color iconBg;
  final Color? descColor;
  final Color? extraDescColor;

  const NotificationTile({
    super.key,
    required this.title,
    required this.desc,
    this.extraDesc,
    required this.time,
    required this.icon,
    required this.iconBg,
    this.descColor,
    this.extraDescColor,
  });

  @override
  Widget build(BuildContext context) {
    final Widget leadingIcon = switch (icon) {
      final String assetPath => Image.asset(
        assetPath,
        width: 24,
        height: 24,
        color: Colors.black,
      ),
      final IconData iconData => Icon(iconData, color: Colors.white, size: 24),
      _ => const SizedBox.shrink(),
    };

    return Column(
      children: [
        CustomBaseTile(
          icon: leadingIcon,
          iconBgColor: iconBg,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(
                  color: descColor ?? Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              if (extraDesc != null) ...[
                const SizedBox(height: 4),
                Text(
                  extraDesc!,
                  style: TextStyle(
                    color: extraDescColor ?? descColor ?? Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFF00D09E), thickness: 0.5, height: 1),
      ],
    );
  }
}
