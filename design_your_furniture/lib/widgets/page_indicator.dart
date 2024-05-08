// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  PageIndicator(this.currentIndex, this.pageCount);

  Widget buildIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
          color: isActive ? Color(0xFF666a84) : Color(0xFFb9bcca),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 3.0),
                blurRadius: 3.0)
          ]),
    );
  }

  buildPageIndicators() {
    List<Widget> indicatorsList = [];
    for (int i = 0; i < pageCount; i++) {
      indicatorsList.add(
          i == currentIndex ? buildIndicator(true) : buildIndicator(false));
    }
    return indicatorsList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: buildPageIndicators(),
    );
  }
}
