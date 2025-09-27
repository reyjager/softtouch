import 'package:get/get.dart';
import 'package:softtouch/modules/auth/login/login_view.dart';
import 'package:softtouch/modules/auth/services/global_auth_service.dart';

class BookingViewModel extends GetxController {
  final List<String> availableDates = [
    'Mon 15',
    'Tue 16',
    'Wed 17',
    'Thu 18',
    'Fri 19',
    'Sat 20',
    'Sun 21',
  ];

  final Map<String, List<String>> _scheduleData = {
    'Mon 15': ['9:00 AM', '10:30 AM', '2:00 PM', '3:30 PM', '5:00 PM'],
    'Tue 16': ['9:00 AM', '11:00 AM', '1:00 PM', '4:00 PM'],
    'Wed 17': ['10:00 AM', '11:30 AM', '2:30 PM', '4:30 PM', '6:00 PM'],
    'Thu 18': ['9:30 AM', '1:30 PM', '3:00 PM', '5:30 PM'],
    'Fri 19': ['9:00 AM', '10:00 AM', '2:00 PM', '4:00 PM', '6:30 PM'],
    'Sat 20': ['10:00 AM', '12:00 PM', '2:00 PM', '4:00 PM'],
    'Sun 21': ['11:00 AM', '1:00 PM', '3:00 PM', '5:00 PM'],
  };

  var selectedDate = Rxn<String>();
  var selectedTime = Rxn<String>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = availableDates.first;
  }

  List<String> getAvailableTimesForDate(String date) {
    return _scheduleData[date] ?? [];
  }

  List<String> getMorningTimes(String date) {
    final times = getAvailableTimesForDate(date);
    return times.where((time) => time.contains('AM') || (time.contains('PM') && int.parse(time.split(':')[0]) == 12)).toList();
  }

  List<String> getAfternoonTimes(String date) {
    final times = getAvailableTimesForDate(date);
    return times.where((time) => time.contains('PM') && int.parse(time.split(':')[0]) != 12).toList();
  }

  void selectDate(String date) {
    selectedDate.value = date;
    selectedTime.value = null;
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }

  void confirmBooking(String date, String time) {
// check first if the user is logged in

    print('Booking confirmed for $date at $time');

    if(GlobalAuthService.isLoggedIn()){
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        Get.snackbar('Booking Confirmed', 'Your booking has been confirmed for $date at $time');
      });
    }else{
      Get.to(()=> LoginView());
    }

  }
}