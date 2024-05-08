// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/stepper_controller.dart';
import 'package:ecommerce_app/modules/checkout/views/checkout_address_screen.dart';
import 'package:ecommerce_app/modules/checkout/views/checkout_orders_screen.dart';
import 'package:ecommerce_app/modules/checkout/views/checkout_payment_screen.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends GetView<CheckoutScreenController> {
  final CheckoutScreenController checkoutController = Get.find();
  CartScreenController cartController = Get.find();
  StepperController stepperController = Get.find();

  @override
  Widget build(BuildContext context) {
    var checkoutItems = cartController.productsInCart;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: getBackButton(context),
        titleSpacing: 0,
        centerTitle: true,
        title: Container(
          height: 40,
          child: Text(
            'Checkout',
            style: TextStyle(
                fontFamily: 'Actonia PERSONAL',
                color: kContrastColor,
                fontSize: 35),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
      ),
      body: Obx(
        () => Theme(
          data: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: kContrastColor,
                  background: Colors.red,
                  secondary: Colors.green,
                ),
          ),
          child: Stepper(
            controlsBuilder: (context, _) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: stepperController.onStepContinued,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            color: kContrastColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          stepperController.index == 2
                              ? 'Confirm and Pay'
                              : 'Continue',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'DM Sans'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: stepperController.onStepCancelled,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                              color: kSecondaryColor, fontFamily: 'DM Sans'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            currentStep: stepperController.index.value,
            type: StepperType.horizontal,
            onStepTapped: (index) {
              stepperController.index.value = index;
            },
            steps: <Step>[
              Step(
                title: Text(
                  'Review order',
                  style: TextStyle(fontSize: 12, fontFamily: 'DM Sans'),
                ),
                content: TotalOrderScreen(),
                isActive: stepperController.index.value >= 0,
                state: stepperController.index.value >= 0
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: Text(
                  'Enter Address',
                  style: TextStyle(fontSize: 12, fontFamily: 'DM Sans'),
                ),
                content: CheckoutAddressScreen(),
                isActive: stepperController.index.value >= 0,
                state: stepperController.index.value >= 1
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: Text(
                  'Pay',
                  style: TextStyle(fontSize: 12, fontFamily: 'DM Sans'),
                ),
                content: CheckoutPaymentScreen(),
                isActive: stepperController.index.value >= 0,
                state: stepperController.index.value >= 2
                    ? StepState.complete
                    : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
