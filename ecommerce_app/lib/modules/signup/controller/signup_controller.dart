import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/firebase/firebase_database.dart';
import 'package:ecommerce_app/modules/login/modal/login_modal.dart';
import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  FirebaseAuthController firebaseAuthController = Get.find();
  final sUser = UserModal().obs;
  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  void validateSignUp() {
    if (signUpFormKey.currentState!.validate()) {
      signUpFromFirebase();
    }
  }

  signUpFromFirebase() async {
    var user = await firebaseAuthController.registerUsingEmailPassword(
      name: nameEditingController.text,
      email: emailEditingController.text,
      password: passwordEditingController.text,
      // phone: phoneEditingController.text
    );
    if (user.runtimeType == User && user != null) {
      Get.offAllNamed(Paths.DASHBOARD);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      FirebaseOrderDatabase.userUid = FirebaseAuth.instance.currentUser?.uid;
    } else {
      Get.snackbar(
        'Sign Up failed!',
        user ?? 'Inconsistent data',
        colorText: Colors.white,
        backgroundColor: kContrastColor,
        duration: Duration(seconds: 1),
      );
    }
  }
}
