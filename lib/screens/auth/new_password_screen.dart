import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String? flowType; // 'forgot_password' or other flows

  const NewPasswordScreen({super.key, this.flowType});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordsMatch = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _passwordsMatch =
          _newPasswordController.text == _confirmPasswordController.text &&
          _newPasswordController.text.isNotEmpty;
    });
  }

  void _changePassword() {
    if (_newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a new password')),
      );
      return;
    }

    if (_confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm your password')),
      );
      return;
    }

    if (!_passwordsMatch) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // Navigate to Home Screen and clear auth flow
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);

    return Scaffold(
      backgroundColor: primaryGreen,
      body: Column(
        children: [
          // Header
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "New Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: darkTeal,
              ),
            ),
          ),

          // Body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: bodyBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      label: "New Password",
                      hintText: "● ● ● ● ● ● ● ●",
                      isPassword: true,
                      suffixIcon: Icons.remove_red_eye_outlined,
                      controller: _newPasswordController,
                      onChanged: (_) => _validatePasswords(),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      label: "Confirm New Password",
                      hintText: "● ● ● ● ● ● ● ●",
                      isPassword: true,
                      suffixIcon: Icons.remove_red_eye_outlined,
                      controller: _confirmPasswordController,
                      onChanged: (_) => _validatePasswords(),
                    ),

                    const SizedBox(height: 80),

                    // Change Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Change Password",
                          style: TextStyle(
                            color: darkTeal,
                            fontSize: 18,
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
        ],
      ),
    );
  }
}
