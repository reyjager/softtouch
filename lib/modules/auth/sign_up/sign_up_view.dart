import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softtouch/controllers/auth_controller.dart';
import 'package:softtouch/model/app_user.dart';
import 'package:softtouch/modules/auth/sign_up/animated_button.dart';
import 'package:softtouch/modules/auth/sign_up/sign_up_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../login/login_view.dart';

class SignupView extends StatelessWidget {

  SignupView();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, vm, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (vm.pageController.hasClients && vm.pageController.page == 1) {
                vm.previousStep();
              } else {
                Get.back();
              }
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: PageView(
          controller: vm.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Step 1 - Name & Email
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hey! What's your name? ✨",
                    style: TextStyle(fontSize: 24),
                  ),
                  TextField(
                    controller: vm.nameController,
                    onChanged: vm.updateName,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: vm.emailController,
                    onChanged: vm.updateEmail,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: vm.passwordController,
                    onChanged: vm.updatePassword,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(height: 32),
                  AnimatedBounceButton(
                    text: "Next",
                    enabled: vm.name.isNotEmpty && vm.email.isNotEmpty && vm.password.isNotEmpty,
                    onPressed: vm.nextStep,
                  ),
                ],
              ),
            ),
            // Step 2 - Phone & Role
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your phone number?", style: TextStyle(fontSize: 24)),
                  TextField(
                    controller: vm.phoneController,
                    onChanged: vm.updatePhone,
                    decoration: InputDecoration(hintText: "Phone"),
                  ),
                  SizedBox(height: 16),
                  Text("Pick your role", style: TextStyle(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text("Client"),
                        selected: vm.role == UserRole.client,
                        onSelected: (_) => vm.updateRole(UserRole.client),
                      ),
                      SizedBox(width: 12),
                      ChoiceChip(
                        label: Text("Stylist"),
                        selected: vm.role == UserRole.stylist,
                        onSelected: (_) => vm.updateRole(UserRole.stylist),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  AnimatedBounceButton(
                    text: "Sign Up",
                    enabled: vm.phone.isNotEmpty,
                                    onPressed: () async {
                                    final authController = Get.find<AuthController>();
                                    final error = await authController.signUp(
                  vm.email,
                  vm.password,
                                    );
                                    if (error == null) {
                  await vm.signup();
                  Get.snackbar('Success', 'Account created successfully! Please sign in.', backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
                  Get.offAll(() => LoginView());
                                    } else {
                  String message = error.contains('Email is already registered') ? 'Email is already in use' : error;
                  Get.snackbar('Sign Up Failed', message, backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
                                    }
                                    },
                  ),
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
