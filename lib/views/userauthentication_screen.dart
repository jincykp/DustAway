import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/auth_button.dart';
import 'package:dustaway/core/widgets/logo_button.dart';
import 'package:flutter/material.dart';

class UserAuthenticationScreen extends StatefulWidget {
  const UserAuthenticationScreen({super.key});

  @override
  State<UserAuthenticationScreen> createState() =>
      _UserAuthenticationScreenState();
}

class _UserAuthenticationScreenState extends State<UserAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 180,
            ),
            LogoButton(),
            SizedBox(
              height: 200,
            ),
            AuthButton(
              text: 'Continue with Google',
              onPressed: () {
                // Google sign-in logic
              },
              backgroundColor: AppColors.greyColor,
              textColor: AppColors.blackColor,
              imagePath: 'assets/images/gimage.png', // Image added
            ),
            SizedBox(
              height: 10,
            ),
            AuthButton(
              text: 'Phone',
              onPressed: () {
                // Phone login logic
              },
              backgroundColor: AppColors.baseColor,
              textColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    ));
  }
}
