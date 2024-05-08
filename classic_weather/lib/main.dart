import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sarcastic_weather/app_routes.dart';
import 'package:sarcastic_weather/binding/home_binding.dart';
import 'package:sarcastic_weather/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.amberAccent,
          dividerHeight: 0,
        ),
      ),
      getPages: AppRoutes.PAGES,
      home: const SplashScreen(),
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
