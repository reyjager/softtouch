import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:softtouch/model/app_user.dart';
import 'package:softtouch/services/firebase_service.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends BaseViewModel {
  
  SignupViewModel();

  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  UserRole role = UserRole.client;

  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void updateName(String v) {
    name = v;
    nameController.text = v;
    notifyListeners();
  }
  
  void updateEmail(String v) {
    email = v;
    emailController.text = v;
    notifyListeners();
  }
  
  void updatePhone(String v) {
    phone = v;
    phoneController.text = v;
    notifyListeners();
  }
  
  void updatePassword(String v) {
    password = v;
    passwordController.text = v;
    notifyListeners();
  }
  
  void updateRole(UserRole v) {
    role = v;
    notifyListeners();
  }

  void nextStep() {
    if (pageController.hasClients) {
      pageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (pageController.hasClients) {
      pageController.previousPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> signup() async {
    setBusy(true);
    
    try {
      final userCredential = await FirebaseService.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = AppUser(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        role: role,
      );
      
      await FirebaseService.firestore.collection('users').doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'role': user.role.toString(),
      });
      
      final box = Hive.box<AppUser>('current_user');
      await box.put('user_key', user);
    } catch (e) {
      throw e;
    } finally {
      setBusy(false);
    }
  }
}
