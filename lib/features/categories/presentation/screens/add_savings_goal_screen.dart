import 'package:finace_app/features/categories/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSavingsGoalScreen extends StatefulWidget {
  const AddSavingsGoalScreen({super.key});

  @override
  State<AddSavingsGoalScreen> createState() => _AddSavingsGoalScreenState();
}

class _AddSavingsGoalScreenState extends State<AddSavingsGoalScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _initialController = TextEditingController();

  IconData _selectedIcon = Icons.savings_rounded;

  final List<IconData> _availableIcons = [
    Icons.savings_rounded,
    Icons.flight_takeoff_rounded,
    Icons.local_mall_rounded,
    Icons.home_rounded,
    Icons.directions_car_rounded,
    Icons.card_giftcard_rounded,
    Icons.laptop_chromebook_rounded,
    Icons.videogame_asset_rounded,
    Icons.fitness_center_rounded,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _initialController.dispose();
    super.dispose();
  }

  void _saveGoal() {
    if (!_formKey.currentState!.validate()) return;

    final String name = _nameController.text.trim();
    final double target = double.tryParse(_targetController.text.trim()) ?? 0.0;
    final double initial = double.tryParse(_initialController.text.trim()) ?? 0.0;

    if (target <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Target price must be greater than 0")),
      );
      return;
    }

    if (initial > target) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Initial savings cannot exceed target price")),
      );
      return;
    }

    final newGoal = SavingGoalModel(
      title: name,
      targetPrice: target,
      savedAmount: initial,
      icon: _selectedIcon,
      iconBgColor: const Color(0xFF4DA6FF), // default icon color matching mockup
    );

    // 1. Save Goal
    CategoryDataStore.addSavingGoal(newGoal);

    // 2. If initial savings exist, create a deposit transaction record
    if (initial > 0) {
      final now = DateTime.now();
      const months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
      ];
      final monthName = months[now.month - 1];
      final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      final subtitle = "$timeStr - $monthName ${now.day}";

      final initialTx = TransactionModel(
        title: "$name deposit",
        subtitle: subtitle,
        amount: initial,
        category: "Savings",
        type: name,
      );
      CategoryDataStore.addTransaction(initialTx);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Goal '$name' created successfully!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);
    const Color fieldBg = Color(0xFFE5F9EF);

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
                      "New Saving Goal",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    const SizedBox(width: 28),
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
                          // Goal Title
                          const Text(
                            "Goal Name",
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
                              controller: _nameController,
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Goal name is required";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                hintText: "e.g. Travel, New laptop",
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B9D8F),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Target Price
                          const Text(
                            "Target Price",
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
                              controller: _targetController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return "Target price is required";
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

                          // Initial savings
                          const Text(
                            "Initial Saving (Optional)",
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
                              controller: _initialController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(
                                fontSize: 16,
                                color: darkTeal,
                                fontWeight: FontWeight.w500,
                              ),
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

                          // Icon selection
                          const Text(
                            "Goal Icon",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: _availableIcons.length,
                            itemBuilder: (context, index) {
                              final isSelected = _selectedIcon == _availableIcons[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIcon = _availableIcons[index];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryGreen : fieldBg,
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(color: darkTeal, width: 2)
                                        : null,
                                  ),
                                  child: Icon(
                                    _availableIcons[index],
                                    color: isSelected ? Colors.white : darkTeal,
                                    size: 24,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 35),

                          // Save green button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _saveGoal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                "Create Goal",
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
