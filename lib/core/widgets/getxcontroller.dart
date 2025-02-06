import 'package:dustaway/core/services/cart_items.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  bool _isInitialized = false; // Add flag to track initialization

  void initializeItems() {
    // Only initialize if not already done
    if (_isInitialized) return;
    _isInitialized = true;

    items.addAll([
      CartItem(
        name: 'Kitchen Cleaning',
        price: 999.00,
        duration: '180 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.8,
        orders: 156,
      ),
      CartItem(
        name: 'Bathroom Cleaning',
        price: 499.00,
        duration: '60 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.2,
        orders: 98,
      ),
      CartItem(
        name: 'Carpet Cleaning',
        price: 699.00,
        duration: '90 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.5,
        orders: 124,
      ),
      CartItem(
        name: 'Fan Cleaning',
        price: 799.00,
        duration: '120 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.6,
        orders: 87,
      ),
      CartItem(
        name: 'Sofa Cleaning',
        price: 399.00,
        duration: '45 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.3,
        orders: 65,
      ),
      CartItem(
        name: 'Floor Cleaning',
        price: 599.00,
        duration: '75 Minutes',
        image: 'assets/images/homecleaning.png',
        rating: 4.4,
        orders: 92,
      ),
    ]);
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
