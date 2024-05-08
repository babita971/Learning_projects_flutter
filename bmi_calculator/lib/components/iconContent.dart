import 'package:flutter/material.dart';
import '../constants.dart';

class IconContentWidget extends StatelessWidget {
  final IconData contentIcon;
  final String contentLabel;

  IconContentWidget({required this.contentIcon, required this.contentLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          contentIcon,
          size: kIconSize,
        ),
        SizedBox(
          height: 15,
        ),
        Text(contentLabel, style: kLabelStyle),
      ],
    );
  }
}
