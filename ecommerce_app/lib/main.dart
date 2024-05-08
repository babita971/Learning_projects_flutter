// ignore_for_file: prefer_const_constructors
import 'package:ecommerce_app/app_routes.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Ecommerce Demo',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          colorScheme: ColorScheme.light().copyWith(
            primary: kPrimaryColor,
          ),
        ),
        initialRoute: Paths.SPLASH_SCREEN,
        getPages: Routes().pages
        // initialBinding: SplashScreenBinding(), Either give initialbinding or initial route
        );
  }
}
