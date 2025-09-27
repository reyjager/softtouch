import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum UserRole { client, stylist, admin }

class ProfileViewModel extends GetxController {
  var isLoading = false.obs;
  var userRole = UserRole.client.obs;
  var userName = 'Cara Sweet'.obs;
  var userEmail = 'cara.sweet@example.com'.obs;
  var userPhone = '+1 234 567 8900'.obs;
  var userImage = 'https://i.pravatar.cc/150?img=2'.obs;
  var totalBookings = 25.obs;
  var completedServices = 20.obs;
  var rating = 4.8.obs;

  List<String> get menuItems {
    switch (userRole.value) {
      case UserRole.client:
        return [
          'My Bookings',
          'Favorite Stylists',
          'Payment Methods',
          'Notifications',
          'Help & Support',
          'Settings',
          'Logout'
        ];
      case UserRole.stylist:
        return [
          'My Schedule',
          'Client Reviews',
          'Earnings',
          'Services Offered',
          'Availability',
          'Notifications',
          'Settings',
          'Logout'
        ];
      case UserRole.admin:
        return [
          'Manage Users',
          'Manage Services',
          'Analytics',
          'Reports',
          'System Settings',
          'Notifications',
          'Settings',
          'Logout'
        ];
    }
  }

  List<IconData> get menuIcons {
    switch (userRole.value) {
      case UserRole.client:
        return [
          Icons.calendar_today,
          Icons.favorite,
          Icons.payment,
          Icons.notifications,
          Icons.help,
          Icons.settings,
          Icons.logout
        ];
      case UserRole.stylist:
        return [
          Icons.schedule,
          Icons.star,
          Icons.attach_money,
          Icons.work,
          Icons.access_time,
          Icons.notifications,
          Icons.settings,
          Icons.logout
        ];
      case UserRole.admin:
        return [
          Icons.people,
          Icons.business,
          Icons.analytics,
          Icons.assessment,
          Icons.admin_panel_settings,
          Icons.notifications,
          Icons.settings,
          Icons.logout
        ];
    }
  }

  void onMenuItemTap(int index) {
    final item = menuItems[index];
    print('Tapped on: $item');
    
    if (item == 'Logout') {
      logout();
    }
  }

  void editProfile() {
    print('Edit profile tapped');
  }

  void logout() {
    print('User logged out');
  }

  void switchRole(UserRole role) {
    userRole.value = role;
    switch (role) {
      case UserRole.client:
        userName.value = 'Cara Sweet';
        userEmail.value = 'cara.sweet@example.com';
        totalBookings.value = 25;
        completedServices.value = 20;
        rating.value = 4.8;
        break;
      case UserRole.stylist:
        userName.value = 'Alison Leman';
        userEmail.value = 'alison.leman@salon.com';
        totalBookings.value = 150;
        completedServices.value = 140;
        rating.value = 4.9;
        break;
      case UserRole.admin:
        userName.value = 'Admin User';
        userEmail.value = 'admin@salon.com';
        totalBookings.value = 0;
        completedServices.value = 0;
        rating.value = 0.0;
        break;
    }
  }
}