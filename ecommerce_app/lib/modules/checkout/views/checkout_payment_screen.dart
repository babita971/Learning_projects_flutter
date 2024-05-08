// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/stepper_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPaymentScreen extends GetView<CheckoutScreenController> {
  final CheckoutScreenController checkoutController = Get.find();
  StepperController stepperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: checkoutController.paymentFormKey,
      child: Card(
        elevation: 10,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Payment Details', style: kBoldCheckoutStyle),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: checkoutController.cardNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name on the card.',
                      labelStyle: kCheckoutFormStyle,
                      hintStyle: kCheckoutFormStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: checkoutController.cardNumController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Card number cannot be empty.';
                    }
                    if (!GetUtils.isNumericOnly(value) || value.length != 16) {
                      return 'Invalid card number.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Card Number',
                      hintText: 'Enter your card number.',
                      labelStyle: kCheckoutFormStyle,
                      hintStyle: kCheckoutFormStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ExpirationFormField(
                  controller: checkoutController.expDateController,
                  decoration: InputDecoration(
                      labelText: "Card Expiration",
                      hintText: "MM/YY",
                      labelStyle: kCheckoutFormStyle,
                      hintStyle: kCheckoutFormStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: checkoutController.cvvController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'CVV number cannot be empty.';
                    }
                    if (!GetUtils.isNumericOnly(value) || value.length != 3) {
                      return 'Invalid CVV number.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'CVV Number',
                      hintText: 'Enter your CVV number.',
                      labelStyle: kCheckoutFormStyle,
                      hintStyle: kCheckoutFormStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
