import 'package:finace_app/features/account_balance/presentation/screens/account_balance_screen.dart';
import 'package:finace_app/features/home/presentation/screens/home_screen.dart';
import 'package:finace_app/features/transaction/presentation/screens/transaction_screen.dart';
import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpensesScreen extends StatefulWidget {
  final String? selectedCategoryName;

  const AddExpensesScreen({super.key, this.selectedCategoryName});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late DateTime _selectedDate;
  late String? _selectedCategory;
  
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _categoriesList = [
    "Food",
    "Transport",
    "Medicine",
    "Groceries",
    "Rent",
    "Gifts",
    "Savings",
    "Entertainment"
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    
    // Set preselected category if passed, otherwise default to first
    if (widget.selectedCategoryName != null &&
        _categoriesList.contains(widget.selectedCategoryName)) {
      _selectedCategory = widget.selectedCategoryName;
    } else {
      _selectedCategory = null;
    }

    // Pre-fill some defaults if matching specific mockups
    if (_selectedCategory == "Food") {
      _amountController.text = "26.00";
      _titleController.text = "Dinner";
    } else if (_selectedCategory == "Transport") {
      _amountController.text = "3.53";
      _titleController.text = "Fuel";
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Format month to string name
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

  void _saveExpense() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }

    final double amountValue = double.tryParse(_amountController.text.replaceAll(r'$', '').trim()) ?? 0.0;
    if (amountValue <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    // Format subtitle matching e.g. "18:27 - April 30"
    final now = DateTime.now();
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final dateStr = "${_getMonthName(_selectedDate.month)} ${_selectedDate.day}";
    final subtitle = "$timeStr - $dateStr";

    final newTx = TransactionModel(
      title: _titleController.text.trim(),
      subtitle: subtitle,
      amount: -amountValue, // Expenses are negative
      category: _selectedCategory!,
      type: _titleController.text.trim(), // simple type mapping
    );

    CategoryDataStore.addTransaction(newTx);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Expense saved successfully!")),
    );

    // Pop back to the Detail screen
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
                      "Add Expenses",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),

              // 2. Form container (Curved bottom sheet)
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
                          // Date picker field
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

                          // Category select dropdown
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: fieldBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  initialValue: _selectedCategory,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                hint: const Text(
                                  "Select the category",
                                  style: TextStyle(
                                    color: Color(0xFF8B9D8F),
                                    fontSize: 15,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: primaryGreen,
                                  size: 28,
                                ),
                                dropdownColor: fieldBg,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: darkTeal,
                                  fontWeight: FontWeight.w500,
                                ),
                                items: _categoriesList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                },
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

                          // Expense Title field
                          const Text(
                            "Expense Title",
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
                                  return "Expense title is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "Enter expense title",
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B9D8F),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Enter Message field (Multiline text area)
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
                              onPressed: _saveExpense,
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
              // Categories active button (represented by layers)
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
