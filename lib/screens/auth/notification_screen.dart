import 'package:finace_app/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../notification/widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF00D09E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Notification",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Color(0xFFF1FFF3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                "Today",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              NotificationTile(
                title: "Reminder!",
                desc:
                    "Set up your automatic savings to meet your savings goal...",
                time: "17:00 - April 24",
                icon: Assets.bell,
                iconBg: const Color(0xFF00D09E),
              ),
              NotificationTile(
                title: "New Update",
                desc: "New transaction has been registered",
                time: "17:00 - April 24",
                icon: Assets.star,
                iconBg: const Color(0xFF00D09E),
              ),
              const SizedBox(height: 10),
              const Text(
                "Yesterday",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              NotificationTile(
                title: "Transactions",
                desc:
                    "Set up your automatic savings to meet your savings goal...",
                extraDesc: "Groceries | Pantry | -\$100.00",
                descColor: Colors.black,
                extraDescColor: Colors.blueAccent,
                time: "17:00 - April 24",
                icon: Assets.s,
                iconBg: const Color(0xFF00D09E),
              ),
              NotificationTile(
                title: "Reminder!",
                desc:
                    "Set up your automatic savings to meet your savings goal...",
                time: "17:00 - April 24",
                icon: Assets.bell,
                iconBg: const Color(0xFF00D09E),
              ),
              const SizedBox(height: 10),
              const Text(
                "This Weekend",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              NotificationTile(
                title: "Expense record",
                desc:
                    "We recommend that you be more attentive to your finances.  ",
                time: "17:00 - April 24",
                icon: Assets.arrow,
                iconBg: const Color(0xFF00D09E),
              ),
              NotificationTile(
                title: "Transactions",
                desc: "A new transaction has been registered",
                time: "17:00 - April 24",
                icon: Assets.s,
                iconBg: const Color(0xFF00D09E),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      color: const Color(0xFFF1FFF3),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          height: 90,
          color: const Color(0xFFF1FFF3),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home, color: Color(0xFF00D09E), size: 30),
              Icon(Icons.bar_chart, color: Colors.grey),
              Icon(Icons.swap_horiz, color: Colors.grey),
              Icon(Icons.layers, color: Colors.grey),
              Icon(Icons.person_outline, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
