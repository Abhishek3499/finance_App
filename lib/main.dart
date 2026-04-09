import 'package:finace_app/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
