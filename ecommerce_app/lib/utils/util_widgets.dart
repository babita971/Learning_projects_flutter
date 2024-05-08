// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getBackButton(context) {
  final BottomNavigationController controller = Get.find();
  return IconButton(
    onPressed: () => {
      Navigator.pop(context),
    },
    icon: Icon(Icons.arrow_back_ios, size: kBackIconSIze),
  );
}

getOrderPlacedDialog() {
  return Get.defaultDialog(
    radius: 10,
    contentPadding: EdgeInsets.all(10),
    title: "Your order is placed!",
    titleStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 24),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   radius: 20,
        //   backgroundColor: kContrastColor,
        //   child: Icon(Icons.check, color: Colors.white, size: 20),
        // ),
        Container(
          height: Get.height / 4,
          width: Get.width / 2,
          child: Image(
            image: AssetImage('images/order4.png'),
          ),
        ),
        Text(
          'Your Kicker will reach you in 5-7 business days.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'DM Sans', fontSize: 14, color: kSecondaryColor),
        )
      ],
    ),
  );
}

getAllOrdersDeletedDialog() {
  return Get.defaultDialog(
    radius: 10,
    contentPadding: EdgeInsets.all(10),
    title: "Your cart is cleared!",
    titleStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 24),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: kContrastColor,
          child: Icon(Icons.check, color: Colors.white, size: 30),
        ),
      ],
    ),
  );
}

class ExpirationFormField extends StatefulWidget {
  ExpirationFormField({
    required this.controller,
    required this.decoration,
    this.obscureText = false,
    this.enabled = true,
  });

  final TextEditingController controller;
  final InputDecoration decoration;
  final bool obscureText;
  final bool enabled;

  @override
  _ExpirationFormFieldState createState() => _ExpirationFormFieldState();
}

class _ExpirationFormFieldState extends State<ExpirationFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      controller: widget.controller,
      decoration: widget.decoration,
      onChanged: (value) {
        setState(() {
          value = value.replaceAll(RegExp(r"\D"), "");
          switch (value.length) {
            case 0:
              widget.controller.text = "MM/YY";
              widget.controller.selection = TextSelection.collapsed(offset: 0);
              break;
            case 1:
              widget.controller.text = "${value}M/YY";
              widget.controller.selection = TextSelection.collapsed(offset: 1);
              break;
            case 2:
              widget.controller.text = "$value/YY";
              widget.controller.selection = TextSelection.collapsed(offset: 2);
              break;
            case 3:
              widget.controller.text =
                  "${value.substring(0, 2)}/${value.substring(2)}Y";
              widget.controller.selection = TextSelection.collapsed(offset: 4);
              break;
            case 4:
              widget.controller.text =
                  "${value.substring(0, 2)}/${value.substring(2, 4)}";
              widget.controller.selection = TextSelection.collapsed(offset: 5);
              break;
          }
          if (value.length > 4) {
            widget.controller.text =
                "${value.substring(0, 2)}/${value.substring(2, 4)}";
            widget.controller.selection = TextSelection.collapsed(offset: 5);
          }
        });
      },
      cursorWidth: 0.0,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
    );
  }
}
