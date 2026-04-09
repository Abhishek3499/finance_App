import 'dart:async';
import 'package:finace_app/core/assets.dart';
import 'package:finace_app/splash%20screen/auth_landing_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Animation Setup (Professional touch ke liye)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    // 2. Real Flow: Logic + Navigation
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    // Yahan tu checks laga sakta hai (e.g. Is user logged in?)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // pushReplacement use karna zaroori hai dev point of view se
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthLandingScreen(),
      ), // Replace with your next screen
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E), // Tera specific BG color
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo from Assets
              Image.asset(
                Assets.splash, // Tera logo path
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 24),
              // FinWise Text
              const Text(
                'FinWise',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontFamily: 'Roboto', // Ya jo bhi use kar raha ho
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy Next Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text("Home")));
}
