import 'package:dustaway/core/services/auth_services.dart';
import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/custom_cards.dart';
import 'package:dustaway/views/userauthentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "My Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 80, 233, 80), // Dark green (left)
                        Color.fromARGB(255, 2, 49, 3), // Faded green (right)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'FE',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Fathima Ebrahim",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '+91 908 786 4233',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 134, 231, 138)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Wallet',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.baseColor)),
                  Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(color: AppColors.whiteColor),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(' Balance- 125',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 45, 133, 48),
                              fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomCard(
              icon: Icons.person,
              text: "Home Cleaning",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(
              icon: Icons.location_on,
              text: "Saved Address ",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(
              icon: Icons.note_sharp,
              text: "Terms & Conditions",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(
              icon: Icons.privacy_tip_outlined,
              text: "Privacy Policy",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(
              icon: Icons.group,
              text: "Refer a friend",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            CustomCard(
              icon: Icons.call,
              text: "Customer Support",
              borderColor: AppColors.greyColor,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _handleLogout(context);
              },
              child: CustomCard(
                icon: Icons.logout_rounded,
                text: "Log Out",
                borderColor: AppColors.greyColor,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    AuthServices auth = AuthServices();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout Confirmation",
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await auth.signout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAuthenticationScreen()));
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
