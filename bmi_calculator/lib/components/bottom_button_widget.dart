import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTapCallback;
  BottomButtonWidget({required this.buttonText, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        color: kBottomContainerColor,
        height: kBottomContainerHeight,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
