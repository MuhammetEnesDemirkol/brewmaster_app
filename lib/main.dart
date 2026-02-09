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
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4B3621),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B3621),
          primary: const Color(0xFF4B3621),
          secondary: const Color(0xFFD4A373),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}