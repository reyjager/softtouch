import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softtouch/controllers/auth_controller.dart';
import 'package:softtouch/modules/home/home_view.dart';
import 'package:softtouch/modules/auth/login/login_view.dart';
import 'package:softtouch/modules/splash_screen/animate_title.dart';
import 'package:softtouch/services/firebase_service.dart';

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
    _initializeAndNavigate();
  }
  
  Future<void> _initializeAndNavigate() async {
    await Future.delayed(const Duration(seconds: 4));
    
    final AuthController authController = Get.put(AuthController());
    
    if (FirebaseService.isInitialized && authController.isLoggedIn) {
      Get.offAll(() => const HomeView());
    } else {
      Get.offAll(() => LoginView());
    }
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