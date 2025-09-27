import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:softtouch/model/app_user.dart';
import 'package:softtouch/modules/auth/sign_up/animated_button.dart';
import 'package:softtouch/modules/auth/sign_up/sign_up_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {

  SignupView();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, vm, child) => Scaffold(
        body: PageView(
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
                    onChanged: vm.updateName,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: vm.updateEmail,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 32),
                  AnimatedBounceButton(
                    text: "Next",
                    enabled: vm.name.isNotEmpty && vm.email.isNotEmpty,
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
                      await vm.signup();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Signup complete! 🎉")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
