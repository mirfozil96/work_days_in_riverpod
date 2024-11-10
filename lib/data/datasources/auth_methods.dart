import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rbc_control/core/utils/utils.dart';

import 'app_storage.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  static Future<void> sendEmailVerification(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        if (context.mounted) {
          Utils.fireSnackBar(context,message: 'Verification email sent\nPlease confirm your email through the link sent to your inbox.', backgroundColor: Colors.green);
        }
      } catch (e) {
        if (context.mounted) {
          Utils.fireSnackBar(context, message: '$e', backgroundColor: Colors.red);
        }
      }
    }
  }

  static Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(fullName);

        if (context.mounted) {
          await sendEmailVerification(context);
        }

        bool isVerified = false;
        final DateTime endTime = DateTime.now().add(const Duration(minutes: 1));  // Waiting for email verification, but no more than 1 minutes
        
        while (!isVerified && DateTime.now().isBefore(endTime)) {
          await Future.delayed(const Duration(seconds: 3));
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          isVerified = _auth.currentUser?.emailVerified ?? false;
          if (isVerified) {
            break;
          }
        }

        if (isVerified) {
          if (context.mounted) {
            Utils.fireSnackBar(context, message: 'Email confirmed. Registration completed.', backgroundColor: Colors.green);
          }
        } else {
          if (context.mounted) {
            Utils.fireSnackBar(context, message: 'Confirmation time expired. Please confirm your email and try again.', backgroundColor: Colors.red);
          }
          await _auth.currentUser?.delete();
        }
        return _auth.currentUser;
      } else {
        if (context.mounted) {
          Utils.fireSnackBar(context, message: 'User creation failed. Please try again.', backgroundColor: Colors.red);
        }
        return null;
      }
    } catch (e) {
      if (context.mounted) {
        Utils.fireSnackBar(context, message: '$e', backgroundColor: Colors.red);
      }
      return null;
    }
  }


  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      // Check if user exists in Firestore
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          // Create new user document
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'displayName': user.displayName,
          });
        }

        // Save the user's UID to SharedPreferences
        await UserStorage.store(key: StorageKey.userUid, value: user.uid);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "An error occurred"),
      ));
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save the user's UID to SharedPreferences
        await UserStorage.store(key: StorageKey.userUid, value: user.uid);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? "An error occurred"),
      ));
      return null;
    }
  }

  static Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }
}
