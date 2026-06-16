import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final String title;
  final String message;
  final String? nextRoute;
  final Widget? nextScreen;

  const SuccessScreen({
    super.key,
    this.title = "Success!",
    this.message = "Your action has been completed successfully.",
    this.nextRoute,
    this.nextScreen,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _proceedNext() {
    if (widget.nextScreen != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.nextScreen!),
        (route) => false,
      );
    } else if (widget.nextRoute != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        widget.nextRoute!,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    }
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
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.check_circle,
                  color: primaryGreen,
                  size: 80,
                ),
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkTeal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkTeal.withValues(alpha: 0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 80),

                    // Done Button
                    SizedBox(
                      width: 220,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _proceedNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
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
