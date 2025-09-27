import 'package:softtouch/model/app_user.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';

class SplashViewModel extends BaseViewModel {
  final Box<AppUser> userBox;

  SplashViewModel(this.userBox);

  Future<String> getInitialRoute() async {
    await Future.delayed(Duration(seconds: 1)); // optional splash delay
    final AppUser? user = userBox.get('currentUser');
    return user != null ? '/home' : '/signup';
  }
}
