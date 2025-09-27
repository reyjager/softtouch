import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:softtouch/model/app_user.dart';
import 'package:stacked/stacked.dart';

class SignupViewModel extends BaseViewModel {
  
  SignupViewModel();

  String name = '';
  String email = '';
  String phone = '';
  UserRole role = UserRole.client;

  PageController pageController = PageController();

  void updateName(String v) {
    name = v;
    notifyListeners();
  }
  
  void updateEmail(String v) {
    email = v;
    notifyListeners();
  }
  
  void updatePhone(String v) {
    phone = v;
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

  Future<void> signup() async {

     final user = AppUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      role: role,
    );

    final box = Hive.box<AppUser>('current_user');
    await box.put('user_key', user);
  }
}
