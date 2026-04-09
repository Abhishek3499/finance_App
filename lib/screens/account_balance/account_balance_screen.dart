import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/period_selector.dart';
import '../home/home_screen.dart';
import 'widgets/balance_header.dart';
import 'widgets/chart_section.dart';
import 'widgets/transaction_list.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  static const Color primaryGreen = Color(0xFF00D09E);
  static const Color bodyBg = Color(0xFFF1FFF3);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: primaryGreen,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const BalanceHeader(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: bodyBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ChartSection(),
                        SizedBox(height: 28),
                        PeriodSelector(),
                        SizedBox(height: 28),
                        TransactionList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      color: bodyBg,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          height: 90,
          color: bodyBg,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                    return;
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.home, color: Colors.grey, size: 30),
              ),
              const Icon(Icons.bar_chart, color: Color(0xFF00D09E), size: 30),
              const Icon(Icons.swap_horiz, color: Colors.grey),
              const Icon(Icons.layers, color: Colors.grey),
              const Icon(Icons.person_outline, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
