import 'package:finace_app/features/auth/presentation/screens/new_password_screen.dart';
import 'package:finace_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SecurityPinScreen extends StatefulWidget {
  final String? flowType; // 'signup' or 'forgot_password'

  const SecurityPinScreen({super.key, this.flowType});

  @override
  State<SecurityPinScreen> createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  late List<TextEditingController> _pinControllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _pinControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _completePin =>
      _pinControllers.map((controller) => controller.text).join();

  void _onAccept() {
    if (_completePin.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits')),
      );
      return;
    }

    // Handle PIN verification based on flow type
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('PIN accepted: $_completePin')));

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      if (widget.flowType == 'signup') {
        // Navigate to next signup step
        debugPrint('Sign Up PIN: $_completePin');
        // TODO: Navigate to next signup screen
      } else if (widget.flowType == 'forgot_password') {
        // Navigate to password reset screen
        debugPrint('Forgot Password PIN: $_completePin');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const NewPasswordScreen(flowType: 'forgot_password'),
          ),
        );
      }
    });
  }

  void _onSendAgain() {
    // Clear all PIN fields
    for (var controller in _pinControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    // Handle resend logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PIN sent again to your email')),
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
            height: MediaQuery.of(context).size.height * 0.22,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Security Pin",
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
                  horizontal: 20,
                  vertical: 50,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Enter Security Pin",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // OTP Row (6 Fields)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => _buildPinInputField(index, darkTeal),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Buttons
                    _actionButton(
                      "Accept",
                      primaryGreen,
                      Colors.white,
                      _onAccept,
                    ),
                    const SizedBox(height: 20),
                    _actionButton(
                      "Send Again",
                      primaryGreen.withValues(alpha: 0.15),
                      darkTeal,
                      _onSendAgain,
                    ),

                    const SizedBox(height: 100),

                    // Social Section
                    const Text(
                      "or sign up with",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialCircle(Icons.facebook),
                        const SizedBox(width: 20),
                        _socialCircle(Icons.g_mobiledata_rounded),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
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

  Widget _buildPinInputField(int index, Color darkTeal) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF00D09E), width: 2),
      ),
      child: TextFormField(
        controller: _pinControllers[index],
        focusNode: _focusNodes[index],
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkTeal,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
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
