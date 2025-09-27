import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'booking_viewmodel.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingViewModel model = Get.put(BookingViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => model.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.pink))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.availableDates.length,
                itemBuilder: (context, index) {
                  final date = model.availableDates[index];
                  final isSelected = model.selectedDate.value == date;
                  return GestureDetector(
                    onTap: () => model.selectDate(date),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.split(' ')[0],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         Divider(thickness: 10.0, color: Colors.yellow,),
                          Text(
                            date.split(' ')[1],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            const SizedBox(height: 12),
            if (model.selectedDate.value != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Morning',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      model.getMorningTimes(model.selectedDate.value!).isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'No available schedule on morning',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: model.getMorningTimes(model.selectedDate.value!).length,
                              itemBuilder: (context, index) {
                                final time = model.getMorningTimes(model.selectedDate.value!)[index];
                                final isSelected = model.selectedTime.value == time;
                                return GestureDetector(
                                  onTap: () => model.selectTime(time),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.pink : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Divider(),
                      const SizedBox(height: 20),
                      const Text(
                        'Afternoon',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      model.getAfternoonTimes(model.selectedDate.value!).isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'No available schedule on afternoon',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: model.getAfternoonTimes(model.selectedDate.value!).length,
                              itemBuilder: (context, index) {
                                final time = model.getAfternoonTimes(model.selectedDate.value!)[index];
                                final isSelected = model.selectedTime.value == time;
                                return GestureDetector(
                                  onTap: () => model.selectTime(time),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.pink : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    'Please select a date first',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            if (model.selectedDate.value != null && model.selectedTime.value != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () => model.confirmBooking(model.selectedDate.value!, model.selectedTime.value!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}