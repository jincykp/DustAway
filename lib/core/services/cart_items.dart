import 'package:get/get.dart';

class CartItem {
  final String name;
  final double price;
  final String duration;
  final String image;
  final double rating;
  final int orders;
  RxInt quantity = 0.obs;

  CartItem({
    required this.name,
    required this.price,
    required this.duration,
    required this.image,
    required this.rating,
    required this.orders,
  });

  double get totalPrice => price * quantity.value;
}
