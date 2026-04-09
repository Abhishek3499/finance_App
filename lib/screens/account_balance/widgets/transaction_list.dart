import 'package:flutter/material.dart';

import '../../../core/assets.dart';
import '../../../widgets/transaction_tile.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Recent Transactions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Keep track of your latest income and expenses',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        SizedBox(height: 24),
        TransactionTile(
          title: 'Salary',
          subtitle: '18:27 - April 30',
          amount: '\$4.000,00',
          type: 'Monthly',
          iconPath: Assets.salary,
          iconBgColor: Color(0xFF6C9EFF),
        ),
        TransactionTile(
          title: 'Groceries',
          subtitle: '17:00 - April 24',
          amount: '-\$100,00',
          type: 'Pantry',
          iconPath: Assets.grocerices,
          iconBgColor: Color(0xFF4DA6FF),
        ),
        TransactionTile(
          title: 'Rent',
          subtitle: '08:30 - April 15',
          amount: '-\$674,40',
          type: 'Rent',
          iconPath: Assets.key,
          iconBgColor: Color(0xFF4DA6FF),
        ),
      ],
    );
  }
}
