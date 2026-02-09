import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B3621),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.coffee, size: 100, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "BrewMaster",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(
                    color: Color(0xFFD4A373),
                  ),
                ],
              ),
            ),

            const Spacer(),

            const Text(
              "Developed by",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Muhammet Enes DEMİRKOL",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}