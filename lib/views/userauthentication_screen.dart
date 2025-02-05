import 'package:dustaway/core/services/auth_services.dart';
import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/auth_button.dart';
import 'package:dustaway/core/widgets/logo_button.dart';
import 'package:dustaway/views/Phone_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthenticationScreen extends StatefulWidget {
  const UserAuthenticationScreen({super.key});

  @override
  State<UserAuthenticationScreen> createState() =>
      _UserAuthenticationScreenState();
}

class _UserAuthenticationScreenState extends State<UserAuthenticationScreen> {
  final TextEditingController phoneController = TextEditingController();
  AuthServices authServices = AuthServices();
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String formatPhoneNumber(String number) {
    // Remove any non-digit characters
    String digits = number.replaceAll(RegExp(r'[^\d]'), '');

    // If number doesn't start with +91 and has 10 digits, add +91
    if (digits.length == 10) {
      return '+91$digits';
    }
    // If number starts with 91 and has 12 digits, add +
    else if (digits.length == 12 && digits.startsWith('91')) {
      return '+$digits';
    }
    // If number already has correct format, return as is
    else if (number.startsWith('+91') && number.length == 13) {
      return number;
    }
    // Return original input if no formatting rules match
    return number;
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a phone number')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Format the phone number before sending
      final formattedNumber = formatPhoneNumber(phoneController.text);

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Verification failed')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneOtpScreen(
                verificationId: verificationId,
                phoneNumber: formattedNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() => isLoading = false);
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void myDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Phone Authentication',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: AppColors.baseColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '9876543210',
                    labelText: 'Enter phone number',
                    prefixText: '+91 ',
                    helperText: 'Enter 10-digit mobile number',
                  ),
                ),
                const SizedBox(height: 20),
                AuthButton(
                  text: isLoading ? "Sending Code..." : "Send Code",
                  onPressed:
                      isLoading ? null : () => verifyPhoneNumber(context),
                  backgroundColor: AppColors.baseColor,
                  textColor: AppColors.whiteColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 180),
                const LogoButton(),
                const SizedBox(height: 200),
                AuthButton(
                  text: 'Continue with Google',
                  onPressed: () {
                    authServices.signInWithGoogle(context);
                  },
                  backgroundColor: AppColors.greyColor,
                  textColor: AppColors.blackColor,
                  imagePath: 'assets/images/gimage.png',
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: 'Phone',
                  onPressed: () => myDialogue(context),
                  backgroundColor: AppColors.baseColor,
                  textColor: AppColors.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
