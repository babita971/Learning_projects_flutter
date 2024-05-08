// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/splash/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/Kicker.png'),
                Text(
                  'World\'s biggest collection of kicks.',
                  textAlign: TextAlign.center,
                  style: kSplashScreenTextStyle,
                ),
              ],
            ),
          ),
          Container(
            height: Get.height / 3,
            width: Get.width / 4,
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/klipartz 8.png'),
          )
        ],
      ),
    );
  }
}
