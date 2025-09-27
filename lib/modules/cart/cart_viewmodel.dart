import 'package:get/get.dart';

class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}

class CartViewModel extends GetxController {
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Add sample items
    cartItems.addAll([
      CartItem(name: 'Hair Cut', price: 25.0),
      CartItem(name: 'Manicure', price: 15.0),
    ]);
  }

  double get total => cartItems.fold(0.0, (sum, item) => sum + item.price);

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void checkout() {
    Get.snackbar('Success', 'Order placed successfully!');
    cartItems.clear();
  }
}