import 'package:finace_app/core/constants/app_assets.dart';
import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/home/presentation/screens/home_screen.dart';
import 'package:finace_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:finace_app/features/transaction/presentation/widgets/transaction_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finace_app/features/categories/presentation/screens/categories_screen.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);
    const Color cardBg = Colors.white;

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
              // 1. Top Header Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Text(
                      "Transaction",
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

              // 2. Summary Balance Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    // Total Balance Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "\$7,783.00",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Income & Expense Cards
                    Row(
                      children: [
                        // Income Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: primaryGreen, width: 1.5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_outward_rounded,
                                        color: primaryGreen,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Income",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "\$4,120.00",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Expense Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueAccent, width: 1.5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(
                                        Icons.call_received_rounded,
                                        color: Colors.blueAccent,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Expense",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "\$1,187.40",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. Body Section with Scrollable Transactions
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
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        // April Header with Calendar Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "April",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkTeal,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00BFA5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        // April Transactions
                        const TransactionHistoryTile(
                          title: "Salary",
                          subtitle: "18:27 - April 30",
                          amount: "\$4.000,00",
                          type: "Monthly",
                          icon: Assets.salary,
                          iconBgColor: Color(0xFF6C9EFF),
                        ),
                        const TransactionHistoryTile(
                          title: "Groceries",
                          subtitle: "17:00 - April 24",
                          amount: "-\$100,00",
                          type: "Pantry",
                          icon: Assets.grocerices,
                          iconBgColor: Color(0xFF4DA6FF),
                        ),
                        const TransactionHistoryTile(
                          title: "Rent",
                          subtitle: "8:30 - April 15",
                          amount: "-\$674,40",
                          type: "Rent",
                          icon: Assets.key,
                          iconBgColor: Color(0xFF2979FF),
                        ),
                        const TransactionHistoryTile(
                          title: "Transport",
                          subtitle: "7:30 - April 08",
                          amount: "-\$4,13",
                          type: "Fuel",
                          icon: Icons.directions_bus_rounded,
                          iconBgColor: Color(0xFF29B6F6),
                        ),
                        const SizedBox(height: 18),

                        // March Header
                        const Text(
                          "March",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkTeal,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // March Transactions
                        const TransactionHistoryTile(
                          title: "Food",
                          subtitle: "19:30 - March 31",
                          amount: "-\$70,40",
                          type: "Dinner",
                          icon: Assets.food,
                          iconBgColor: Color(0xFF42A5F5),
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
              // Floating/Highlighted Active Transaction Center Button
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.swap_horiz_rounded,
                  color: Color(0xFF003D33),
                  size: 30,
                ),
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
                child: const Icon(Icons.layers_outlined, color: Colors.grey, size: 30),
              ),
              const Icon(Icons.person_outline_rounded, color: Colors.grey, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
