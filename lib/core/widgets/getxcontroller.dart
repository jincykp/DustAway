import 'package:dustaway/core/services/cart_items.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;

  void initializeItems() {
    for (int i = 0; i < 6; i++) {
      items.add(
        CartItem(
          name: 'Bathroom Cleaning',
          price: 499.00,
          duration: '60 Minutes',
          image: 'assets/images/carpet.png',
          rating: 4.2,
          orders: 23,
        ),
      );
    }
  }

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity.value);
  }

  void incrementItem(int index) {
    items[index].quantity.value++;
    update();
  }

  void decrementItem(int index) {
    if (items[index].quantity.value > 0) {
      items[index].quantity.value--;
      update();
    }
  }
}
