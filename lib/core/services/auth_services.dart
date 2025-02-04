import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dustaway/views/userhome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final UserService userService = UserService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credentials
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Save user details to Firestore using the auth UID
          await userService.saveUserDetails(
            user.uid, // Using the Firebase Auth UID
            googleUser.email,
          );

          // Navigate to HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserhomeScreen(),
            ),
          );
        }
      }
    } catch (e) {
      log("Google Sign-In failed: $e");
    }
  }
}

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save user details to Firestore
  Future<void> saveUserDetails(String uid, String email) async {
    try {
      // Reference to the 'users' collection
      CollectionReference users = _firestore.collection('users');

      // Create or update the user document with their UID
      await users.doc(uid).set({
        'email': email,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("User details saved successfully.");
    } catch (e) {
      print("Error saving user details: $e");
    }
  }
}
