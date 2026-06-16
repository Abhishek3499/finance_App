import 'package:finace_app/core/constants/app_assets.dart';
import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/home/presentation/screens/home_screen.dart';
import 'package:finace_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:finace_app/features/transaction/presentation/screens/transaction_screen.dart';
import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:finace_app/features/categories/presentation/screens/add_expenses_screen.dart';
import 'package:finace_app/features/transaction/presentation/widgets/transaction_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryDetailScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);

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
                    Text(
                      category.name,
                      style: const TextStyle(
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

              // 2. Stats Section
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
                            value: "-\$1.187.40",
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

              // 3. Transactions List Sheet
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
                    child: ValueListenableBuilder<List<TransactionModel>>(
                      valueListenable: CategoryDataStore.transactionsNotifier,
                      builder: (context, allTransactions, child) {
                        // Filter transactions by current category
                        final list = allTransactions
                            .where((tx) => tx.category.toLowerCase() == category.name.toLowerCase())
                            .toList();

                        // Group transactions by month
                        final Map<String, List<TransactionModel>> grouped = {};
                        for (var tx in list) {
                          // Extract month from subtitle (e.g. "18:27 - April 30" -> "April")
                          final parts = tx.subtitle.split(' - ');
                          String month = "Recent";
                          if (parts.length > 1) {
                            final monthPart = parts[1].split(' ');
                            if (monthPart.isNotEmpty) {
                              month = monthPart[0];
                            }
                          }
                          grouped.putIfAbsent(month, () => []).add(tx);
                        }

                        return Column(
                          children: [
                            Expanded(
                              child: list.isEmpty
                                  ? const Center(
                                      child: Text(
                                        "No transactions yet in this category",
                                        style: TextStyle(color: Colors.grey, fontSize: 15),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(24),
                                      itemCount: grouped.keys.length,
                                      itemBuilder: (context, mIndex) {
                                        final month = grouped.keys.elementAt(mIndex);
                                        final monthTxs = grouped[month]!;

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              month,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: darkTeal,
                                              ),
                                            ),
                                            const SizedBox(height: 14),
                                            ...monthTxs.map((tx) {
                                              return TransactionHistoryTile(
                                                title: tx.title,
                                                subtitle: tx.subtitle,
                                                amount: tx.formattedAmount,
                                                type: tx.type,
                                                icon: category.icon,
                                                iconBgColor: category.iconBgColor,
                                              );
                                            }),
                                            const SizedBox(height: 10),
                                          ],
                                        );
                                      },
                                    ),
                            ),

                            // Bottom Green Add Expenses button
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
                                        builder: (context) => AddExpensesScreen(
                                          selectedCategoryName: category.name,
                                        ),
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
                                    "Add Expenses",
                                    style: TextStyle(
                                      color: darkTeal,
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
              // Categories tab active (represented by layers)
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
