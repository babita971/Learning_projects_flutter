// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button_widget.dart';
import 'package:bmi_calculator/components/reusableCard.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  // final String bmiResult;
  // final String resultText;
  // final String resultInterpretation;

  final CalculatorBrain calcObject;

  ResultPage({required this.calcObject});
  @override
  Widget build(BuildContext context) {
    print('askahslaslas');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(calcObject.getResult()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.bottomLeft,
              child: Text('Your Result', style: kTitleTextStyle),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCardWidget(
              cardColor: kActiveCardColor,
              childWidget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    calcObject.getResult().toUpperCase(),
                    style: kResultTextStyle,
                  ),
                  Text(
                    calcObject.calculateBMI(),
                    style: kBMIResultTextStyle,
                  ),
                  Text(
                    calcObject.getInterpretation(),
                    // 'BMI is very low BMI is very low BMI is very lowBMI is very lowBMI is very lowBMI is very low',
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButtonWidget(
            buttonText: 'RE-CALCULATE',
            onTapCallback: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ResultPage(),
              //   ),
              // );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
