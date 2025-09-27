import 'package:flutter/material.dart';
import 'package:softtouch/modules/home/home_view.dart';
import 'package:softtouch/modules/splash_screen/animate_title.dart';

// --- Splash Screen ---
class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 143, 177),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            const Icon(Icons.spa, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Beauty Salon",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
              AnimatedTitle(title: "Its a beautiful day"),
           
          ],
        ),
      ),
    );
  }
}

// --- Your Home Page (from earlier code) ---
class BeautyHomePage extends StatelessWidget {
  const BeautyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: const Center(child: Text("🏠 Home Page Here")),
    );
  }
}