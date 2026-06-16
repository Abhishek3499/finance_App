import 'package:finace_app/core/widgets/custom_text_field.dart';
import 'package:finace_app/features/auth/presentation/screens/login_screen.dart';
import 'package:finace_app/features/auth/presentation/screens/security_pin_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      body: Column(
        children: [
          // Header
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003D33),
              ),
            ),
          ),

          // Body
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF1FFF3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                child: Column(
                  children: [
                    const CustomTextField(
                      label: "Full Name",
                      hintText: "John Doe",
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Email",
                      hintText: "example@example.com",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Mobile Number",
                      hintText: "+ 123 456 789",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Date Of Birth",
                      hintText: "DD / MM / YYYY",
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Password",
                      hintText: "● ● ● ● ● ● ● ●",
                      isPassword: true,
                      suffixIcon: Icons.remove_red_eye_outlined,
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Confirm Password",
                      hintText: "● ● ● ● ● ● ● ●",
                      isPassword: true,
                      suffixIcon: Icons.remove_red_eye_outlined,
                    ),

                    const SizedBox(height: 25),

                    // Terms & Privacy
                    const Text.rich(
                      TextSpan(
                        text: "By continuing, you agree to\n",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Terms of Use ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(text: "and "),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    // Sign Up Button
                    _buildSignUpButton(context),

                    const SizedBox(height: 20),

                    // Footer Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              color: Color(0xFF00D09E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SecurityPinScreen(flowType: 'signup'),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D09E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          "Sign Up",
          style: TextStyle(
            color: Color(0xFF003D33),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
