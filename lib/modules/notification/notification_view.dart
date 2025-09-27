import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification_viewmodel.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationViewModel viewModel = Get.put(NotificationViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Obx(() => viewModel.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : viewModel.notifications.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No notifications yet', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: viewModel.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = viewModel.notifications[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: notification.isRead ? Colors.grey : Colors.pink,
                          child: Icon(
                            notification.type == 'booking' ? Icons.calendar_today : Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification.message),
                            const SizedBox(height: 4),
                            Text(
                              notification.time,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        onTap: () => viewModel.markAsRead(index),
                      ),
                    );
                  },
                )),
    );
  }
}