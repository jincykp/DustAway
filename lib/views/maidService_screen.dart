import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/getxcontroller.dart';
import 'package:dustaway/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MaidserviceScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  MaidserviceScreen({super.key}) {
    final cartController = Get.put(CartController());
    cartController.initializeItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GetBuilder<CartController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 120,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset(item.image),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '(${item.rating}/5) ${item.orders} Orders',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.duration,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        "₹ ${item.price.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: item.quantity.value > 0 ? 120 : 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: item.quantity.value > 0
                                      ? null
                                      : const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 80, 233, 80),
                                            Color.fromARGB(255, 2, 49, 3),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                  color: item.quantity.value > 0
                                      ? Colors.grey[200]
                                      : null, // Light grey background when quantity > 0
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(18),
                                    bottomRight: const Radius.circular(
                                        18), // Same radius in both states
                                  ),
                                ),
                                child: Obx(() => item.quantity.value > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                controller.decrementItem(index),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 80,
                                                    233, 80), // Green text
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${item.quantity.value}',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 80,
                                                  233, 80), // Green text
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                controller.incrementItem(index),
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 80,
                                                    233, 80), // Green text
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () =>
                                            controller.incrementItem(index),
                                        child: const Center(
                                          child: Text(
                                            'Add +',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      )),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GetBuilder<CartController>(
                builder: (controller) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${controller.totalItems} items | ₹${controller.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartScreen()));
                                      },
                                      child: Text(
                                        'VIEW CART',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_sharp,
                                  color: AppColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
