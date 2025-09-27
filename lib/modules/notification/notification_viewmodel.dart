import 'package:get/get.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final String type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

class NotificationViewModel extends GetxController {
  var isLoading = false.obs;
  var notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;
    
    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      notifications.value = [
        NotificationItem(
          title: 'Booking Confirmed',
          message: 'Your appointment has been confirmed for tomorrow at 2:00 PM',
          time: '2 hours ago',
          type: 'booking',
        ),
        NotificationItem(
          title: 'New Message',
          message: 'You have a new message from your stylist',
          time: '5 hours ago',
          type: 'message',
        ),
        NotificationItem(
          title: 'Reminder',
          message: 'Don\'t forget your appointment tomorrow',
          time: '1 day ago',
          type: 'reminder',
          isRead: true,
        ),
      ];
      isLoading.value = false;
    });
  }

  void markAsRead(int index) {
    notifications[index].isRead = true;
    notifications.refresh();
  }
}