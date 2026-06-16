import 'package:finace_app/core/constants/app_assets.dart';
import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/home/presentation/screens/home_screen.dart';
import 'package:finace_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:finace_app/features/transaction/presentation/screens/transaction_screen.dart';
import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:finace_app/features/categories/presentation/screens/saving_goal_detail_screen.dart';
import 'package:finace_app/features/categories/presentation/screens/add_savings_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavingsDetailScreen extends StatelessWidget {
  const SavingsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);
    const Color blueAccent = Color(0xFF007BFF);
    const Color lightBlueBg = Color(0xFFE5F0FF);

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
              // 1. Header Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Text(
                      "Savings",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const NotificationScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
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
                          Icons.notifications_none_rounded,
                          color: primaryGreen,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Stats Section (Total Balance & Total Expense as per mockup)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: _StatItem(
                            label: "Total Balance",
                            value: "\$7,783.00",
                            iconPath: Assets.totalbalance,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.white.withValues(alpha: 0.7),
                              thickness: 1,
                              width: 1,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: _StatItem(
                            label: "Total Expense",
                            value: "-\$1,187.40",
                            iconPath: Assets.totalexpen,
                            isExpense: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Progress Bar
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: darkTeal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * 0.25,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "30%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "\$20,000.00",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: darkTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
              ),
              const SizedBox(height: 20),

              // 3. Grid of Goals (Curved body sheet)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: bodyBg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: ValueListenableBuilder<List<SavingGoalModel>>(
                      valueListenable: CategoryDataStore.savingsGoalsNotifier,
                      builder: (context, goals, child) {
                        return Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.75,
                                ),
                                itemCount: goals.length,
                                itemBuilder: (context, index) {
                                  final goal = goals[index];
                                  final isTravel = goal.title.toLowerCase() == "travel";

                                  // Icon Widget rendering
                                  Widget iconWidget;
                                  if (goal.title.toLowerCase() == "wedding") {
                                    // Custom interlocking rings for high fidelity
                                    iconWidget = const OverlappingRingsIcon(color: blueAccent, size: 28);
                                  } else {
                                    iconWidget = Icon(
                                      goal.icon,
                                      color: isTravel ? Colors.white : blueAccent,
                                      size: 30,
                                    );
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SavingGoalDetailScreen(goal: goal),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        // Card Box Container
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: isTravel ? blueAccent : lightBlueBg,
                                              borderRadius: BorderRadius.circular(24),
                                            ),
                                            child: Center(child: iconWidget),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Label outside the card container
                                        Text(
                                          goal.title,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Bottom Green Add More button
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AddSavingsGoalScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryGreen,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    "Add More",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color primaryGreen = Color(0xFF00D09E);

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
                  Navigator.pushReplacement(
                     context,
                     PageRouteBuilder(
                       pageBuilder: (context, animation, secondaryAnimation) =>
                           const HomeScreen(),
                       transitionDuration: Duration.zero,
                       reverseTransitionDuration: Duration.zero,
                     ),
                  );
                },
                child: const Icon(Icons.home_outlined, color: Colors.grey, size: 30),
              ),
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
                child: const Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 30),
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
                child: const Icon(Icons.swap_horiz_rounded, color: Colors.grey, size: 30),
              ),
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.layers_rounded,
                  color: Color(0xFF003D33),
                  size: 30,
                ),
              ),
              const Icon(Icons.person_outline_rounded, color: Colors.grey, size: 30),
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
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isExpense ? Colors.blue : Colors.white,
          ),
        ),
      ],
    );
  }
}

class OverlappingRingsIcon extends StatelessWidget {
  final Color color;
  final double size;
  const OverlappingRingsIcon({super.key, required this.color, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 2,
            top: size * 0.1,
            child: Container(
              width: size * 0.65,
              height: size * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2.5),
              ),
            ),
          ),
          Positioned(
            right: 2,
            bottom: size * 0.1,
            child: Container(
              width: size * 0.65,
              height: size * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
