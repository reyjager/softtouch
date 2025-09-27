import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  bool get isLoggedIn => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    if (FirebaseService.isInitialized) {
      _user.bindStream(FirebaseService.auth.authStateChanges());
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      if (!FirebaseService.isInitialized) {
        return 'Firebase not initialized';
      }
      if (email.isEmpty || password.isEmpty) {
        return 'Email and password cannot be empty';
      }
      await FirebaseService.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      print('Sign in error: $e');
      if (e.toString().contains('user-not-found')) {
        return 'No account found with this email';
      } else if (e.toString().contains('wrong-password')) {
        return 'Incorrect password';
      } else if (e.toString().contains('invalid-email')) {
        return 'Invalid email format';
      }
      return 'Sign in failed: ${e.toString()}';
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      if (!FirebaseService.isInitialized) {
        return 'Firebase not initialized';
      }
      if (email.isEmpty || password.isEmpty) {
        return 'Email and password cannot be empty';
      }
      if (password.length < 6) {
        return 'Password must be at least 6 characters';
      }
      await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      print('Sign up error: $e');
      if (e.toString().contains('email-already-in-use')) {
        return 'Email is already registered';
      } else if (e.toString().contains('invalid-email')) {
        return 'Invalid email format';
      } else if (e.toString().contains('weak-password')) {
        return 'Password is too weak';
      }
      return 'Sign up failed: ${e.toString()}';
    }
  }

  Future<void> signOut() async {
    try {
      if (FirebaseService.isInitialized) {
        await FirebaseService.auth.signOut();
      }
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}