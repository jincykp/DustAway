import 'package:dustaway/core/theme/colors.dart';
import 'package:dustaway/core/widgets/auth_button.dart';
import 'package:dustaway/views/userhome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const PhoneOtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends State<PhoneOtpScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  bool isLoading = false;
  bool isResending = false;
  final focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> verifyOTP() async {
    // Validate OTP
    String otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter complete OTP')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification successful!')),
        );

        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserhomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage = 'Verification failed';

        // Provide specific error messages
        if (e.code == 'invalid-verification-code') {
          errorMessage = 'Invalid OTP. Please check and try again.';
        } else if (e.code == 'invalid-verification-id') {
          errorMessage =
              'Verification session expired. Please request new OTP.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> resendOTP() async {
    if (isResending) return;

    setState(() => isResending = true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserhomeScreen()),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Verification failed')),
          );
        },
        codeSent: (String newVerificationId, int? resendToken) {
          setState(() {
            // Clear existing OTP fields
            for (var controller in otpControllers) {
              controller.clear();
            }
            // Focus on first field
            FocusScope.of(context).requestFocus(focusNodes[0]);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New OTP sent successfully')),
          );
        },
        codeAutoRetrievalTimeout: (_) {},
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to resend OTP. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => isResending = false);
      }
    }
  }

  Widget buildOTPTextField(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        autofocus: index == 0,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: AppColors.baseColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            } else {
              focusNodes[index].unfocus();
            }
          } else if (index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.baseColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'OTP VERIFICATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.baseColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'We have sent the verification code to',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => buildOTPTextField(index),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthButton(
                    text: isLoading ? "Verifying..." : "Verify",
                    onPressed: isLoading ? null : verifyOTP,
                    backgroundColor: AppColors.baseColor,
                    textColor: AppColors.whiteColor,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Didn't receive the code?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: isResending ? null : resendOTP,
                    child: Text(
                      isResending ? "Sending..." : "Resend New Code",
                      style: TextStyle(
                        color: isResending ? Colors.grey : AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
