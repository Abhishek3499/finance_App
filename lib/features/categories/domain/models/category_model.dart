import 'package:flutter/material.dart';

class TransactionModel {
  final String title;
  final String subtitle;
  final double amount; // Negative for expense, positive for income/deposit
  final String category; // e.g. "Food", "Transport", "Savings"
  final String type; // e.g. "Monthly", "Pantry", "Fuel", "Dinner", or goal title like "Travel"

  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.category,
    required this.type,
  });

  String get formattedAmount {
    final absAmount = amount.abs().toStringAsFixed(2);
    final sign = amount < 0 ? '-' : '';
    // Format to match user mockup, e.g. -$100,00 or -$4,13
    return '$sign\$$absAmount'.replaceAll('.', ',');
  }
}

class CategoryModel {
  final String name;
  final dynamic icon; // String (asset path) or IconData
  final Color iconBgColor;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.iconBgColor,
  });
}

class SavingGoalModel {
  final String title;
  final double targetPrice;
  final double savedAmount;
  final dynamic icon; // String (asset path) or IconData
  final Color iconBgColor;

  SavingGoalModel({
    required this.title,
    required this.targetPrice,
    required this.savedAmount,
    required this.icon,
    required this.iconBgColor,
  });

  SavingGoalModel copyWith({
    String? title,
    double? targetPrice,
    double? savedAmount,
    dynamic icon,
    Color? iconBgColor,
  }) {
    return SavingGoalModel(
      title: title ?? this.title,
      targetPrice: targetPrice ?? this.targetPrice,
      savedAmount: savedAmount ?? this.savedAmount,
      icon: icon ?? this.icon,
      iconBgColor: iconBgColor ?? this.iconBgColor,
    );
  }
}

// In-memory data store for interactive updates
class CategoryDataStore {
  CategoryDataStore._();

  static final ValueNotifier<List<TransactionModel>> transactionsNotifier =
      ValueNotifier<List<TransactionModel>>([
    // Food transactions
    TransactionModel(
      title: "Dinner",
      subtitle: "18:27 - April 30",
      amount: -26.00,
      category: "Food",
      type: "Dinner",
    ),
    TransactionModel(
      title: "Delivery Pizza",
      subtitle: "15:00 - April 24",
      amount: -18.35,
      category: "Food",
      type: "Delivery",
    ),
    TransactionModel(
      title: "Lunch",
      subtitle: "12:30 - April 15",
      amount: -15.40,
      category: "Food",
      type: "Lunch",
    ),
    TransactionModel(
      title: "Brunch",
      subtitle: "9:30 - April 08",
      amount: -12.13,
      category: "Food",
      type: "Brunch",
    ),
    TransactionModel(
      title: "Dinner",
      subtitle: "20:30 - March 31",
      amount: -27.20,
      category: "Food",
      type: "Dinner",
    ),
    
    // Transport transactions
    TransactionModel(
      title: "Fuel",
      subtitle: "18:27 - March 30",
      amount: -3.53,
      category: "Transport",
      type: "Fuel",
    ),
    TransactionModel(
      title: "Car Parts",
      subtitle: "15:00 - March 30",
      amount: -28.75,
      category: "Transport",
      type: "Repair",
    ),
    TransactionModel(
      title: "New Tires",
      subtitle: "12:47 - February 10",
      amount: -373.99,
      category: "Transport",
      type: "Tires",
    ),
    TransactionModel(
      title: "Car Wash",
      subtitle: "9:30 - February 09",
      amount: -9.74,
      category: "Transport",
      type: "Wash",
    ),
    TransactionModel(
      title: "Public Transport",
      subtitle: "7:30 - February 01",
      amount: -1.24,
      category: "Transport",
      type: "Transit",
    ),

    // Groceries transactions (matching mockup)
    TransactionModel(
      title: "Grocery box",
      subtitle: "18:27 - April 30",
      amount: -37.17,
      category: "Groceries",
      type: "Pantry",
    ),
    TransactionModel(
      title: "Vegatables",
      subtitle: "15:00 - April 24",
      amount: -21.54,
      category: "Groceries",
      type: "Fresh",
    ),
    TransactionModel(
      title: "Pantry",
      subtitle: "12:30 - April 15",
      amount: -24.56,
      category: "Groceries",
      type: "Pantry",
    ),
    TransactionModel(
      title: "Vegatables",
      subtitle: "9:30 - February 08",
      amount: -24.56,
      category: "Groceries",
      type: "Fresh",
    ),
    TransactionModel(
      title: "Pantry",
      subtitle: "20:30 - February 02",
      amount: -47.17,
      category: "Groceries",
      type: "Pantry",
    ),

    // Rent transactions (matching mockup)
    TransactionModel(
      title: "Rent - April",
      subtitle: "18:27 - April 30",
      amount: -370.17,
      category: "Rent",
      type: "Apartment",
    ),
    TransactionModel(
      title: "Rent - March",
      subtitle: "15:00 - March 30",
      amount: -370.17,
      category: "Rent",
      type: "Apartment",
    ),
    TransactionModel(
      title: "Rent - February",
      subtitle: "12:30 - February 15",
      amount: -370.17,
      category: "Rent",
      type: "Apartment",
    ),
    TransactionModel(
      title: "Rent - January",
      subtitle: "9:30 - January 15",
      amount: -370.17,
      category: "Rent",
      type: "Apartment",
    ),

    // Gifts transactions (matching mockup)
    TransactionModel(
      title: "Gift card",
      subtitle: "18:27 - April 30",
      amount: -37.17,
      category: "Gifts",
      type: "Voucher",
    ),
    TransactionModel(
      title: "Teddy bear",
      subtitle: "15:00 - April 24",
      amount: -20.17,
      category: "Gifts",
      type: "Toy",
    ),
    TransactionModel(
      title: "Birthday presents",
      subtitle: "12:30 - March 15",
      amount: -47.17,
      category: "Gifts",
      type: "Birthday",
    ),
    TransactionModel(
      title: "Teddy bear",
      subtitle: "9:30 - March 08",
      amount: -20.17,
      category: "Gifts",
      type: "Toy",
    ),
    TransactionModel(
      title: "Toys for client",
      subtitle: "20:30 - February 02",
      amount: -18.17,
      category: "Gifts",
      type: "Toy",
    ),

    // Medicine transactions (matching mockup)
    TransactionModel(
      title: "Painkiller/Aspirin",
      subtitle: "18:27 - April 30",
      amount: -20.17,
      category: "Medicine",
      type: "Pills",
    ),
    TransactionModel(
      title: "Clinical test doctor",
      subtitle: "15:00 - March 24",
      amount: -47.17,
      category: "Medicine",
      type: "Doctor",
    ),
    TransactionModel(
      title: "Vitamin-C",
      subtitle: "12:30 - March 15",
      amount: -37.17,
      category: "Medicine",
      type: "Vitamins",
    ),
    TransactionModel(
      title: "Flu pill",
      subtitle: "9:30 - February 08",
      amount: -18.17,
      category: "Medicine",
      type: "Pills",
    ),

    // Entertainment transactions (matching mockup)
    TransactionModel(
      title: "Spotify",
      subtitle: "18:27 - April 30",
      amount: -37.17,
      category: "Entertainment",
      type: "Music",
    ),
    TransactionModel(
      title: "Netflix",
      subtitle: "15:00 - April 24",
      amount: -20.17,
      category: "Entertainment",
      type: "Movies",
    ),
    TransactionModel(
      title: "Cinema license",
      subtitle: "12:30 - March 15",
      amount: -47.17,
      category: "Entertainment",
      type: "Cinema",
    ),
    TransactionModel(
      title: "Netflix",
      subtitle: "9:30 - February 08",
      amount: -20.17,
      category: "Entertainment",
      type: "Movies",
    ),

    // Travel savings deposits (matching mockup)
    TransactionModel(
      title: "Travel Deposit",
      subtitle: "19:56 - April 30",
      amount: 217.77,
      category: "Savings",
      type: "Travel",
    ),
    TransactionModel(
      title: "Travel Deposit",
      subtitle: "17:42 - April 14",
      amount: 217.77,
      category: "Savings",
      type: "Travel",
    ),
    TransactionModel(
      title: "Travel Deposit",
      subtitle: "12:30 - April 02",
      amount: 217.77,
      category: "Savings",
      type: "Travel",
    ),

    // New House savings deposits (matching mockup)
    TransactionModel(
      title: "House Deposit",
      subtitle: "18:54 - April 15",
      amount: 477.17,
      category: "Savings",
      type: "New House",
    ),
    TransactionModel(
      title: "House Deposit",
      subtitle: "16:47 - January 10",
      amount: 103.47,
      category: "Savings",
      type: "New House",
    ),
    TransactionModel(
      title: "House Deposit",
      subtitle: "14:30 - January 09",
      amount: 44.84,
      category: "Savings",
      type: "New House",
    ),

    // Car savings deposits (matching mockup)
    TransactionModel(
      title: "Car Deposit",
      subtitle: "18:54 - July 10",
      amount: 381.32,
      category: "Savings",
      type: "Car",
    ),
    TransactionModel(
      title: "Car Deposit",
      subtitle: "17:00 - May 08",
      amount: 129.89,
      category: "Savings",
      type: "Car",
    ),
    TransactionModel(
      title: "Car Deposit",
      subtitle: "14:30 - May 08",
      amount: 85.04,
      category: "Savings",
      type: "Car",
    ),

    // Wedding savings deposits (matching mockup)
    TransactionModel(
      title: "Wedding Deposit",
      subtitle: "18:54 - November 15",
      amount: 87.32,
      category: "Savings",
      type: "Wedding",
    ),
    TransactionModel(
      title: "Wedding Deposit",
      subtitle: "17:00 - September 10",
      amount: 23.59,
      category: "Savings",
      type: "Wedding",
    ),
    TransactionModel(
      title: "Wedding Deposit",
      subtitle: "14:30 - September 10",
      amount: 185.34,
      category: "Savings",
      type: "Wedding",
    ),
  ]);

  static final ValueNotifier<List<SavingGoalModel>> savingsGoalsNotifier =
      ValueNotifier<List<SavingGoalModel>>([
    SavingGoalModel(
      title: "Travel",
      targetPrice: 1962.93,
      savedAmount: 653.31,
      icon: Icons.flight_takeoff_rounded,
      iconBgColor: const Color(0xFF007BFF),
    ),
    SavingGoalModel(
      title: "New House",
      targetPrice: 569200.00,
      savedAmount: 625.48,
      icon: Icons.home_rounded,
      iconBgColor: const Color(0xFF007BFF),
    ),
    SavingGoalModel(
      title: "Car",
      targetPrice: 14390.00,
      savedAmount: 596.25,
      icon: Icons.directions_car_rounded,
      iconBgColor: const Color(0xFF007BFF),
    ),
    SavingGoalModel(
      title: "Wedding",
      targetPrice: 34700.00,
      savedAmount: 296.25,
      icon: Icons.favorite_rounded,
      iconBgColor: const Color(0xFF007BFF),
    ),
  ]);

  static void addTransaction(TransactionModel tx) {
    final currentList = List<TransactionModel>.from(transactionsNotifier.value);
    currentList.insert(0, tx);
    transactionsNotifier.value = currentList;
  }

  static void addSavingGoal(SavingGoalModel goal) {
    final currentGoals = List<SavingGoalModel>.from(savingsGoalsNotifier.value);
    currentGoals.add(goal);
    savingsGoalsNotifier.value = currentGoals;
  }

  static void depositToGoal(String goalTitle, double amount, TransactionModel tx) {
    // 1. Add transaction
    addTransaction(tx);

    // 2. Update goal saved amount
    final currentGoals = List<SavingGoalModel>.from(savingsGoalsNotifier.value);
    final index = currentGoals.indexWhere((g) => g.title.toLowerCase() == goalTitle.toLowerCase());
    if (index != -1) {
      final updatedGoal = currentGoals[index].copyWith(
        savedAmount: currentGoals[index].savedAmount + amount,
      );
      currentGoals[index] = updatedGoal;
      savingsGoalsNotifier.value = currentGoals;
    }
  }
}
