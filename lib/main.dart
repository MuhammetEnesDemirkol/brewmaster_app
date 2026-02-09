import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const BrewMasterApp());
}

class BrewMasterApp extends StatelessWidget {
  const BrewMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BrewMaster',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primaryColor: const Color(0xFF4E342E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4E342E),
          primary: const Color(0xFF4E342E),
          secondary: const Color(0xFFC69C6D),
          surface: Colors.white,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}