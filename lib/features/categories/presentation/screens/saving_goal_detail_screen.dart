import 'package:finace_app/core/constants/app_assets.dart';
import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/home/presentation/screens/home_screen.dart';
import 'package:finace_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:finace_app/features/transaction/presentation/screens/transaction_screen.dart';
import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:finace_app/features/categories/presentation/screens/add_savings_deposit_screen.dart';
import 'package:finace_app/features/transaction/presentation/widgets/transaction_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavingGoalDetailScreen extends StatelessWidget {
  final SavingGoalModel goal;

  const SavingGoalDetailScreen({super.key, required this.goal});

  String _formatCurrency(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    parts[0] = parts[0].replaceAllMapped(reg, (Match m) => '${m[1]},');
    if (value % 1 == 0) {
      return parts[0];
    }
    return '${parts[0]}.${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);
    const Color progressBlue = Color(0xFF80B3FF);

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
          child: ValueListenableBuilder<List<SavingGoalModel>>(
            valueListenable: CategoryDataStore.savingsGoalsNotifier,
            builder: (context, goals, child) {
              // Find the current goal to show updated reactive stats
              final currentGoal = goals.firstWhere(
                (g) => g.title.toLowerCase() == goal.title.toLowerCase(),
                orElse: () => goal,
              );

              final double progressRatio = currentGoal.targetPrice > 0
                  ? (currentGoal.savedAmount / currentGoal.targetPrice).clamp(0.0, 1.0)
                  : 0.0;
              final String progressPercent = (progressRatio * 100).toStringAsFixed(0);

              // Hardcoded progress percentages and targets to match the specific mockup specs if matching Travel/etc.
              final String barPercent = currentGoal.title.toLowerCase() == "travel" ? "40%" : "$progressPercent%";
              final String barTarget = "\$${_formatCurrency(currentGoal.targetPrice)}";

              return Column(
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
                          currentGoal.title,
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

                  // 2. Premium Saving Stats Card (Large white card with circular progress chart)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Left Section: Stats labels
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.bookmark_border_rounded,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Goal",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "\$${_formatCurrency(currentGoal.targetPrice)}",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: darkTeal,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.check_box_outlined,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "Amount Saved",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "\$${_formatCurrency(currentGoal.savedAmount)}",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: primaryGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 15),

                              // Right Section: Rounded blue container with Circular progress chart
                              Container(
                                height: 105,
                                width: 105,
                                decoration: BoxDecoration(
                                  color: progressBlue,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 10,
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: CircularProgressIndicator(
                                          value: currentGoal.title.toLowerCase() == "travel" ? 0.40 : progressRatio,
                                          strokeWidth: 5,
                                          backgroundColor: Colors.white.withValues(alpha: 0.35),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 22,
                                      child: Icon(
                                        currentGoal.icon,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      child: Text(
                                        currentGoal.title == "New House" ? "House" : currentGoal.title,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Horizontal Dark Progress Bar with green progress (mockup style)
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: 26,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: darkTeal,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: currentGoal.title.toLowerCase() == "travel" ? 0.40 : progressRatio,
                                child: Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      barPercent,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      barTarget,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Underbar text: checkmark + "30% Of Your Expenses, Looks Good."
                          Row(
                            children: [
                              Image.asset(Assets.check, height: 14, width: 14),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text(
                                  "30% Of Your Expenses, Looks Good.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 3. Transactions/Deposits List Sheet
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
                            // Filter deposits for this goal
                            final deposits = allTransactions
                                .where((tx) =>
                                    tx.category.toLowerCase() == "savings" &&
                                    (tx.type.toLowerCase() == currentGoal.title.toLowerCase() ||
                                     (currentGoal.title.toLowerCase() == "new house" && tx.type.toLowerCase() == "house")))
                                .toList();

                            // Group deposits by month
                            final Map<String, List<TransactionModel>> grouped = {};
                            for (var tx in deposits) {
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
                                  child: deposits.isEmpty
                                      ? const Center(
                                          child: Text(
                                            "No deposits recorded yet for this goal",
                                            style: TextStyle(color: Colors.grey, fontSize: 15),
                                          ),
                                        )
                                      : ListView.builder(
                                          padding: const EdgeInsets.all(24),
                                          itemCount: grouped.keys.length,
                                          itemBuilder: (context, mIndex) {
                                            final month = grouped.keys.elementAt(mIndex);
                                            final monthDeposits = grouped[month]!;

                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      month,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: darkTeal,
                                                      ),
                                                    ),
                                                    // Small green circular calendar icon on the right side
                                                    Container(
                                                      padding: const EdgeInsets.all(6),
                                                      decoration: const BoxDecoration(
                                                        color: primaryGreen,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.calendar_month_rounded,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 14),
                                                ...monthDeposits.map((tx) {
                                                  return TransactionHistoryTile(
                                                    title: tx.title,
                                                    subtitle: tx.subtitle,
                                                    amount: tx.formattedAmount,
                                                    type: currentGoal.title == "New House" ? "House" : currentGoal.title,
                                                    icon: currentGoal.icon,
                                                    iconBgColor: currentGoal.iconBgColor,
                                                  );
                                                }),
                                                const SizedBox(height: 10),
                                              ],
                                            );
                                          },
                                        ),
                                ),

                                // Bottom Green Add savings button
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
                                            builder: (context) => AddSavingsDepositScreen(
                                              goal: currentGoal,
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
                                        "Add savings",
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
              );
            },
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
