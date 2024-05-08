import 'package:flutter/material.dart';

class ReusableCardWidget extends StatelessWidget {
  final Color cardColor;
  final Widget? childWidget;
  final VoidCallback? onTapFunction;

  ReusableCardWidget(
      {required this.cardColor, this.childWidget, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: cardColor),
        child: childWidget,
      ),
    );
  }
}
