import 'package:finace_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:finace_app/core/widgets/transaction_tile.dart';
import 'package:finace_app/core/widgets/period_selector.dart';
import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:finace_app/features/transaction/presentation/screens/transaction_screen.dart';
import 'package:finace_app/features/categories/presentation/screens/categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);

    return Scaffold(
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header Section
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Welcome Back",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          Text(
                            "Good Morning",
                            style: TextStyle(color: darkTeal),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 200,
                              ),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const NotificationScreen(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none,
                            color: Color(0xFF00D09E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _StatItem(
                          label: "Total Balance",
                          value: "\$7,783.00",
                          iconPath: Assets.totalbalance,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                            width: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          label: "Total Expense",
                          value: "-\$1.187.40",
                          iconPath: Assets.totalexpen,
                          isExpense: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Progress Bar with Text
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // 1. Background (The Dark Bar - Pure rectangular on the right side)
                          Container(
                            height: 35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF003D33), // darkTeal
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          // 2. White Section (Right side bar with the curve on its left)
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            left:
                                MediaQuery.of(context).size.width *
                                0.25, // Jitna progress hai utna left se start
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    40,
                                  ), // Yeh white side ka curve andar dega
                                  bottomLeft: Radius.circular(40),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),

                          // 3. Text Overlay
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "30%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\$20,000.00",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF003D33),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(Assets.check, height: 15, width: 15),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              "30% Of Your Expenses, Looks Good.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // 2. White Body Section
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
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // Stats Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            // 🔵 Left Circular Progress with Label
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: const CircularProgressIndicator(
                                          value: 0.5,
                                          strokeWidth: 2,
                                          backgroundColor: Colors.white,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Image.asset(
                                        Assets.car,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Savings\nOn Goals",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,

                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(width: 20),

                            // 🔹 Divider (FIXED)
                            Container(
                              height: 90,
                              width: 1,
                              color: Colors.white,
                            ),

                            const SizedBox(width: 20),

                            // 📊 Right Section (MAIN FIX 🔥)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🔹 Revenue Row
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Assets.revenue,
                                        height: 30,
                                        width: 30,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),

                                      // 🔹 Text section
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Revenue Last Week",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black.withValues(alpha: 0.7),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              "-\$4.000.00",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color:
                                                    Colors.black, // same color
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // 🔹 Divider Line
                                  Container(height: 1, color: Colors.white),

                                  const SizedBox(height: 12),

                                  // 🔹 Food Row
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Assets.food,
                                        height: 35,
                                        width: 35,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),

                                      // 🔹 Text section
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Food Last Week",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black.withValues(alpha: 0.7),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              "-\$100,00",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color:
                                                    Colors.blue, // same color
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Period Selector Toggle
                      const PeriodSelector(),

                      const SizedBox(height: 25),

                      // Transaction List
                      const TransactionTile(
                        title: "Salary",
                        subtitle: "18:27 - April 30",
                        amount: "\$4.000,00",
                        type: "Monthly",
                        iconPath: Assets.salary,
                        iconBgColor: Color(0xFF6C9EFF),
                      ),

                      const TransactionTile(
                        title: "Groceries",
                        subtitle: "17:00 - April 24",
                        amount: "-\$100,00",
                        type: "Pantry",
                        iconPath: Assets.grocerices,
                        iconBgColor: Color(0xFF4DA6FF),
                      ),
                      const TransactionTile(
                        title: "Rent",
                        subtitle: "8:30 - April 15",
                        amount: "-\$674,40",
                        type: "Rent",
                        iconPath: Assets.key,
                        iconBgColor: Color(0xFF4DA6FF),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.home, color: Color(0xFF00D09E), size: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AccountBalanceScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: const Icon(Icons.bar_chart, color: Colors.grey, size: 30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const TransactionScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: const Icon(Icons.swap_horiz, color: Colors.grey, size: 30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CategoriesScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: const Icon(Icons.layers, color: Colors.grey, size: 30),
              ),
              const Icon(Icons.person_outline, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final String iconPath;
  final bool isExpense;
  const _StatItem({
    required this.label,
    required this.value,
    required this.iconPath,
    this.isExpense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(iconPath, height: 14, width: 14),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.black)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isExpense ? Colors.blue : Colors.white,
          ),
        ),
      ],
    );
  }
}
