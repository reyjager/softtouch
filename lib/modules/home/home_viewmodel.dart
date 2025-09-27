import 'package:get/get.dart';
import 'package:softtouch/modules/home/home_view.dart';
import 'package:softtouch/modules/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import '../booking/booking_view.dart';
import '../notification/notification_view.dart';
import '../cart/cart_view.dart';

class HomeViewmodel extends BaseViewModel {
  HomeViewmodel() {}

  routePage(int index){
    switch(index){
      case 1:
        navigateToHome();  
      case 2:
        navigateToBooking();
      case 3:
        navigateToNotification();
      case 4:
        navigateToProfile(); 
    }
    
  }

  void navigateToHome() {
    Get.to(() => const HomeView());
  }
  void navigateToBooking() {
    Get.to(() => const BookingView());
  }
  void navigateToNotification() {
    Get.to(() => const NotificationView());
  }
  void navigateToProfile() {
    Get.to(() => const ProfileView());
  }
  void navigateToCart() {
    Get.to(() => const CartView());
  }
}
