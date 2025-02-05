import 'package:dustaway/core/theme/colors.dart';
import 'package:flutter/material.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.baseColor,
      ),
      child: Center(
          child: Text(
        'Logo',
        style:
            TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.bold),
      )),
    );
  }
}
