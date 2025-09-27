import 'package:hive/hive.dart';
import '../../../model/app_user.dart';

class GlobalAuthService {
  static const String _roleBoxName = 'roleBox';
  static const String _appUserBoxName = 'appUserBox';
  static const String _userKey = 'currentUser';

  // check if login
  static bool isLoggedIn() {
    final appUserBox = Hive.box<AppUser>(_appUserBoxName);
    return appUserBox.containsKey(_userKey);
  }

  // logged in user
  static AppUser? getLoggedInUser() {
    final appUserBox = Hive.box<AppUser>(_appUserBoxName);
    return appUserBox.get(_userKey);
  }

  // save user to hive
  static Future<void> saveUser(AppUser user) async {
    final appUserBox = Hive.box<AppUser>(_appUserBoxName);
    final roleBox = Hive.box<UserRole>(_roleBoxName);
    
    await appUserBox.put(_userKey, user);
    await roleBox.put('activeRole', user.role); // Set initial active role
  }

  // get current active role
  static UserRole? getCurrentRole() {
    final roleBox = Hive.box<UserRole>(_roleBoxName);
    return roleBox.get('activeRole');
  }

  // set active role
  static Future<void> setActiveRole(UserRole role) async {
    final user = getLoggedInUser();
    if (user != null && canSwitchToRole(user, role)) {
      final roleBox = Hive.box<UserRole>(_roleBoxName);
      await roleBox.put('activeRole', role);
    }
  }

  // check if user can switch to role
  static bool canSwitchToRole(AppUser user, UserRole targetRole) {
    if (user.role == UserRole.client) {
      return targetRole == UserRole.client;
    }
    return true; // admin and stylist can switch to any role
  }

  // log out
  static Future<void> logout() async {
    final appUserBox = Hive.box<AppUser>(_appUserBoxName);
    final roleBox = Hive.box<UserRole>(_roleBoxName);
    await appUserBox.delete(_userKey);
    await roleBox.delete('activeRole');
  }
}