import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSavingsDepositScreen extends StatefulWidget {
  final SavingGoalModel goal;

  const AddSavingsDepositScreen({super.key, required this.goal});

  @override
  State<AddSavingsDepositScreen> createState() => _AddSavingsDepositScreenState();
}

class _AddSavingsDepositScreenState extends State<AddSavingsDepositScreen> {
  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;
  final TextEditingController _amountController = TextEditingController();
  late TextEditingController _titleController;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _titleController = TextEditingController(text: "${widget.goal.title} deposit");
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00D09E),
              onPrimary: Colors.white,
              onSurface: Color(0xFF003D33),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveDeposit() {
    if (!_formKey.currentState!.validate()) return;

    final double amountValue = double.tryParse(_amountController.text.replaceAll(r'$', '').trim()) ?? 0.0;
    if (amountValue <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid deposit amount")),
      );
      return;
    }

    final now = DateTime.now();
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final dateStr = "${_getMonthName(_selectedDate.month)} ${_selectedDate.day}";
    final subtitle = "$timeStr - $dateStr";

    final newTx = TransactionModel(
      title: _titleController.text.trim(),
      subtitle: subtitle,
      amount: amountValue, // positive for saving deposits
      category: "Savings",
      type: widget.goal.title, // goals are mapped to type
    );

    CategoryDataStore.depositToGoal(widget.goal.title, amountValue, newTx);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deposit of \$${amountValue.toStringAsFixed(2)} added to ${widget.goal.title}!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);
    const Color fieldBg = Color(0xFFE5F9EF);

    final String formattedDate = "${_getMonthName(_selectedDate.month)} ${_selectedDate.day}, ${_selectedDate.year}";

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
              // Header
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
                      "Add Savings",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    const SizedBox(width: 28), // placeholder spacing
                  ],
                ),
              ),

              // Form Sheet
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
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                        children: [
                          // Date picker
                          const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _pickDate,
                            child: Container(
                              height: 55,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: fieldBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: darkTeal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    color: primaryGreen,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Target Goal
                          const Text(
                            "Goal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 55,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.goal.title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Amount field
                          const Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: fieldBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _amountController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Amount is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "0.00",
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B9D8F),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Saving Title field
                          const Text(
                            "Savings Title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: fieldBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _titleController,
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Savings title is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "Enter savings title",
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B9D8F),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Message Area
                          Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: fieldBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _messageController,
                              maxLines: 4,
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Message",
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B9D8F),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),

                          // Save green button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _saveDeposit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
