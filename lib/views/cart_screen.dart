import 'package:dustaway/core/services/cart_items.dart';
import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/dottdline.dart';
import 'package:dustaway/core/widgets/getxcontroller.dart';
import 'package:dustaway/views/my_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Card(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Selected Services List
              GetBuilder<CartController>(
                builder: (controller) {
                  final selectedItems = controller.items
                      .where((item) => item.quantity.value > 0)
                      .toList();
                  return Column(
                    children: [
                      for (int i = 0; i < selectedItems.length; i++)
                        _buildSelectedService(
                          '${i + 1}. ${selectedItems[i].name}',
                          selectedItems[i].quantity.value,
                          '₹${selectedItems[i].price.toStringAsFixed(2)}',
                          i,
                          controller,
                          selectedItems[i],
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),
              Text(
                "Add more services",
                style: TextStyle(color: AppColors.specialTextColor),
              ),
              const SizedBox(height: 20),

              // Frequently Added Services Section
              const Text(
                'Frequently added services',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildFrequentlyAddedServices(),

              // Coupon Code Section
              const SizedBox(height: 24),
              _buildCouponSection(),

              // Wallet Balance
              const SizedBox(height: 16),
              _buildWalletInfo(),

              // Bill Details
              const SizedBox(height: 24),
              _buildBillDetails(),

              // Book Slot Button
              const SizedBox(height: 24),
              _buildBottomTotalSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedService(String name, int quantity, String price,
      int index, CartController controller, CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Reduced bottom padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 13), // Slightly reduced font size
            ),
          ),
          const SizedBox(width: 4), // Reduced spacing
          Row(
            mainAxisSize: MainAxisSize.min, // Keep row as small as possible
            children: [
              Container(
                height: 28, // Reduced container height
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 28, // Reduced width
                      height: 28, // Reduced height
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon:
                            const Icon(Icons.remove, size: 14), // Smaller icon
                        onPressed: () => controller
                            .decrementItem(controller.items.indexOf(item)),
                      ),
                    ),
                    SizedBox(
                      width: 24, // Reduced width
                      child: Text(
                        quantity.toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 13), // Reduced font size
                      ),
                    ),
                    SizedBox(
                      width: 28, // Reduced width
                      height: 28, // Reduced height
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add, size: 14), // Smaller icon
                        onPressed: () => controller
                            .incrementItem(controller.items.indexOf(item)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Reduced spacing
              Text(
                '₹${(double.parse(price.replaceAll('₹', ''))).toInt()}', // Remove decimals
                style: const TextStyle(fontSize: 13), // Reduced font size
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFrequentlyAddedServices() {
    return GetBuilder<CartController>(
      builder: (controller) {
        final unselectedItems =
            controller.items.where((item) => item.quantity.value == 0).toList();
        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: unselectedItems.length,
            itemBuilder: (context, index) {
              final item = unselectedItems[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${item.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                onPressed: () => controller.incrementItem(
                                    controller.items.indexOf(item)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCouponSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 230, 224, 224)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            color: AppColors.greyColor,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Coupon Code',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 189, 179, 179)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Coupon Code',
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        suffixIcon: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 80, 233, 80),
                                Color.fromARGB(255, 2, 49, 3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Apply',
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletInfo() {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 30,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your wallet balance is ₹125, you can redeem ₹10 in this order.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillDetails() {
    return GetBuilder<CartController>(
      builder: (controller) {
        final selectedItems =
            controller.items.where((item) => item.quantity.value > 0).toList();
        const taxRate = 0.05; // 5% tax
        final subtotal = controller.totalAmount;
        final tax = subtotal * taxRate;
        final couponDiscount = 50.0; // Example fixed discount
        final total = subtotal + tax - couponDiscount;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyColor),
            color: const Color.fromARGB(255, 247, 246, 246),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                color: AppColors.greyColor,
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Bill Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ...selectedItems.map((item) => _buildBillRow(item.name,
                  '₹${(item.price * item.quantity.value).toStringAsFixed(2)}')),
              _buildBillRow('Taxes and Fees', '₹${tax.toStringAsFixed(2)}'),
              _buildBillRow('Coupon Code', '-₹$couponDiscount',
                  isDiscount: true),
              _buildDottedDivider(),
              _buildBillRow('Total', '₹${total.toStringAsFixed(2)}',
                  isBold: true),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillRow(String label, String amount,
      {bool isBold = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isDiscount ? Colors.green : null,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: CustomPaint(
          size: const Size(double.infinity, 4),
          painter: DottedLinePainter(
            width: 1,
            spacing: 15,
            color: const Color.fromARGB(255, 189, 187, 187),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTotalSection(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        const taxRate = 0.05;
        final subtotal = controller.totalAmount;
        final tax = subtotal * taxRate;
        final couponDiscount = 50.0;
        final total = subtotal + tax - couponDiscount;

        return Container(
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
                    'Grand Total  |  ₹${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAccountScreen()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 80, 233, 80),
                          Color.fromARGB(255, 2, 49, 3),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Book Slot',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
