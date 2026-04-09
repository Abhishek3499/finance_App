import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import 'security_pin_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);
    const Color darkTeal = Color(0xFF003D33);

    return Scaffold(
      backgroundColor: primaryGreen,
      body: Column(
        children: [
          // Header Section
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: darkTeal,
              ),
            ),
          ),

          // Body Section
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
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    // Reset Password Title & Description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Reset Password?",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: darkTeal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: TextStyle(
                              fontSize: 13,
                              color: darkTeal.withOpacity(0.7),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Email Input
                    const CustomTextField(
                      label: "Enter Email Address",
                      hintText: "example@example.com",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 30),

                    // Next Step Button
                    _buildButton("Next Step", primaryGreen, Colors.black, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecurityPinScreen(
                            flowType: 'forgot_password',
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 60),

                    // Sign Up Button (Light Tint)
                    _buildButton(
                      "Sign Up",
                      primaryGreen.withValues(alpha: 0.15),
                      darkTeal,
                      () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      "or sign up with",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 15),

                    // Social Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialCircle(Icons.facebook),
                        const SizedBox(width: 20),
                        _socialCircle(Icons.g_mobiledata_rounded),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Footer
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black54),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF00D09E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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

  // Reusable Method for buttons
  Widget _buildButton(
    String title,
    Color bg,
    Color textCol,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 220,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textCol,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _socialCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, size: 30, color: const Color(0xFF003D33)),
    );
  }
}
