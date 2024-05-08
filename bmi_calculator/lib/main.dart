// ignore_for_file: prefer_const_constructors
// Color(0xFF0A0D22),
import 'package:flutter/material.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:bmi_calculator/constants.dart';

void main() => runApp(BMICalculator());


class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryAppColor,
          appBarTheme: AppBarTheme(backgroundColor: kAppScaffolderBackground),
          scaffoldBackgroundColor: kAppScaffolderBackground),
      home: InputPage(),
    );
  }
}
