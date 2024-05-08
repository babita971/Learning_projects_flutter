import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/firebase/firebase_database.dart';
import 'package:ecommerce_app/modules/login/modal/login_modal.dart';
import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginController extends GetxController {
  FirebaseAuthController firebaseAuthController = Get.find();
  final user = UserModal().obs;
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  String getUserName() {
    return emailEditingController.text;
  }

  validateLogin() async {
    if (loginFormKey.currentState!.validate()) {
      loginFromFirebase();
    }
  }

  loginFromFirebase() async {
    var user = await firebaseAuthController.signInUsingEmailPassword(
      email: emailEditingController.text,
      password: passwordEditingController.text,
    );
    if (user.runtimeType == User && user != null) {
      Get.offAllNamed(Paths.DASHBOARD);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      FirebaseOrderDatabase.userUid = FirebaseAuth.instance.currentUser?.uid;
    } else {
      Get.snackbar(
        'Login failed!',
        user ?? 'Invalid credentials',
        colorText: Colors.white,
        backgroundColor: kContrastColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('${FirebaseAuth.instance.currentUser}');
      Get.offAllNamed(Paths.DASHBOARD);
    }

    return firebaseApp;
  }

  googleSignInFromFirebase() async {
    var user = await firebaseAuthController.signInWithGoogle();
    if (user.runtimeType == User && user != null) {
      Get.offAllNamed(Paths.DASHBOARD);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      FirebaseOrderDatabase.userUid = FirebaseAuth.instance.currentUser?.uid;
    } else {
      Get.snackbar(
        'Google authentication failed!',
        user ?? 'Inconsistent data',
        colorText: Colors.white,
        backgroundColor: kContrastColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  facebookSignInFromFirebase() async {
    var user = await firebaseAuthController.signInWithFacebook();
    if (user.runtimeType == User && user != null) {
      Get.offAllNamed(Paths.DASHBOARD);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      FirebaseOrderDatabase.userUid = FirebaseAuth.instance.currentUser?.uid;
    } else {
      Get.snackbar(
        'Facebook authentication failed!',
        user ?? 'Inconsistent data',
        colorText: Colors.white,
        backgroundColor: kContrastColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
