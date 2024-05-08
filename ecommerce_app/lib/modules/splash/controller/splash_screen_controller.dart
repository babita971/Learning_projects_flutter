// ignore_for_file: unused_import

import 'dart:async';

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/modules/login/views/login_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  bool isLoggedIn = false;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? isLoggedIn;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if (isLoggedIn) {
      goToDashboard();
    } else {
      goToLoginScreen();
    }
  }

  goToDashboard() {
    Timer(const Duration(seconds: 1), () => {Get.offAllNamed(Paths.DASHBOARD)});
  }

  goToLoginScreen() {
    Timer(const Duration(seconds: 1), () => {Get.offAllNamed(Paths.LOGIN)});
  }
}
