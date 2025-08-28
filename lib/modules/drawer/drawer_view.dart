import 'package:flutter/material.dart';
import 'package:softtouch/modules/drawer/custom_drawer.dart';

class DrawerView  extends StatelessWidget{
  const DrawerView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
        userName: 'John Doe',
        userEmail: 'john.doe@example.com',
        userPhotoUrl: 'https://example.com/photo.jpg',
        backgroundColor: Colors.pink[50],
        items: [
          DrawerItem(
            title: 'Home',
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          DrawerItem(
            title: 'Profile',
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile
            },
          ),
          DrawerItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          DrawerItem(
            title: 'Notifications',
            icon: Icons.notifications,
            onTap: () {
              Navigator.pop(context);
              // Navigate to notifications
            },
            badgeCount: 5,
          ),
        
        ],
        
        footer: Container(
       
        child: Column(
          children: [

          
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Language'),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.pink,
                  ),
                ],
              ),
            ),
              Divider(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Version: 1.0.0'),
                  const Text('1.0.0'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Build: 100'),
                  const Text('100'),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
        onHeaderTap: () {
          Navigator.pop(context);
          // Navigate to profile
        },
      );
  }

}