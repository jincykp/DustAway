import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String? imagePath; // Optional image
  final Color textColor; // Custom text color

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.imagePath,
    this.textColor = Colors.black, // Default text color if not provided
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: screenWidth * 1, // Set width to 80% of screen width
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath!,
                  width: 34,
                  height: 34,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: textColor, // Use the passed text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
