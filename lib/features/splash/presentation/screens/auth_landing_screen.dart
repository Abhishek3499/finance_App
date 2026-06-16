import 'package:finace_app/core/constants/app_assets.dart';
import 'package:finace_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:finace_app/features/auth/presentation/screens/login_screen.dart';
import 'package:finace_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors from your screenshot
    const Color bgColor = Color(0xFFDFF7E2);
    const Color primaryGreen = Color(0xFF00D09E);
    const Color darkText = Color(0xFF003D33);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // 1. Logo Section
              Image.asset(
                Assets.splash1, // Logo with green icon
                height: 120,
              ),
              const SizedBox(height: 10),
              const Text(
                'FinWise',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),

              // 2. Subtitle (Lorem Ipsum placeholder)
              const SizedBox(height: 10),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 1),

              // 3. Log In Button
              _buildButton(
                text: 'Log In',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                bgColor: primaryGreen,
                textColor: darkText,
              ),

              const SizedBox(height: 16),

              // 4. Sign Up Button (Light version)
              _buildButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SignUpScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                bgColor: primaryGreen.withValues(alpha: 0.15),
                textColor: darkText,
              ),

              // 5. Forgot Password
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ForgotPasswordScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Custom Button Widget
  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required Color bgColor,
    required Color textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners like SS
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
