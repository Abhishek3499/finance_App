import 'package:flutter/material.dart';

class PeriodSelector extends StatefulWidget {
  const PeriodSelector({super.key});

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  String selectedPeriod = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          _buildOption("Daily"),
          _buildOption("Weekly"),
          _buildOption("Monthly"),
        ],
      ),
    );
  }

  Widget _buildOption(String title) {
    bool isActive = selectedPeriod == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPeriod = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF00D09E) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
