import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color headerBg = Color(0xFF00D09E);
    const Color bodyBg = Color(0xFFF1FFF3);

    return Scaffold(
      backgroundColor: headerBg,
      body: Column(
        children: [
          // Top Header Section
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D33),
              ),
            ),
          ),

          // Main Body with Curves
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
                    const CustomTextField(
                      label: "Username Or Email",
                      hintText: "example@example.com",
                    ),
                    const SizedBox(height: 20),
                    const CustomTextField(
                      label: "Password",
                      hintText: "● ● ● ● ● ● ● ●",
                      isPassword: true,
                      suffixIcon: Icons.remove_red_eye_outlined,
                    ),

                    const SizedBox(height: 40),

                    // Log In Button
                    _actionButton(
                      "Log In",
                      const Color(0xFF00D09E),
                      Colors.white,
                      () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),

                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003D33),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign Up Button
                    _actionButton(
                      "Sign Up",
                      const Color(0xFFE5F9EF),
                      const Color(0xFF003D33),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      "Use Fingerprint To Access",
                      style: TextStyle(color: Color(0xFF003D33)),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      "or sign up with",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 15),

                    // Social Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: _socialIcon(Icons.facebook),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: _socialIcon(Icons.g_mobiledata_rounded),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
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

  Widget _actionButton(
    String title,
    Color bg,
    Color textCol,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, size: 30, color: const Color(0xFF003D33)),
    );
  }
}
