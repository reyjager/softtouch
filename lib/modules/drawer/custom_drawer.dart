import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userPhotoUrl;
  final List<DrawerItem> items;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback? onHeaderTap;
  final Widget? footer;

  const CustomDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userPhotoUrl,
    required this.items,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.onHeaderTap,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor ?? Colors.blueGrey[900],
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildItems(),
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        userName ?? 'Guest User',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      accountEmail: Text(
        userEmail ?? 'user@example.com',
        style: TextStyle(color: textColor?.withOpacity(0.8) ?? const Color.fromARGB(179, 6, 6, 6)),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: userPhotoUrl != null
            ? NetworkImage(userPhotoUrl!)
            : null,
        child: userPhotoUrl == null
            ? const Icon(Icons.person, color: Colors.blueGrey)
            : null,
      ),
      decoration: BoxDecoration(
        color: backgroundColor?.withOpacity(0.8) ?? Colors.blue[800],
      ),
      onDetailsPressed: onHeaderTap,
    );
  }

  List<Widget> _buildItems() {
    return items.map((item) => _buildListItem(item)).toList();
  }

  Widget _buildListItem(DrawerItem item) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(
        item.title,
        
      ),
      onTap: item.onTap,
      trailing: item.badgeCount != null
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text(
                item.badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final int? badgeCount;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.badgeCount,
  });
}
