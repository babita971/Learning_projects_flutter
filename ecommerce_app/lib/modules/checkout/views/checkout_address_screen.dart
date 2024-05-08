// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:country_list_pick/country_list_pick.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutAddressScreen extends GetView<CheckoutScreenController> {
  final CheckoutScreenController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: checkoutController.addressFormKey,
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(12),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: checkoutController.address1Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address Line 1 cannot be empty.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Address Line 1', hintStyle: kCheckoutFormStyle),
              ),
              TextFormField(
                controller: checkoutController.address2Controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address Line 2 cannot be empty.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Address Line 2(optional)',
                    hintStyle: kCheckoutFormStyle),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: CountryListPick(
                        onChanged: ((value) {
                          checkoutController.countryController.text =
                              value.toString();
                        }),
                        initialSelection:
                            checkoutController.countryController.text.isEmpty
                                ? '93'
                                : checkoutController.countryController.text),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: checkoutController.phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number cannot be empty.';
                        }
                        if (!GetUtils.isNumericOnly(value) ||
                            value.length != 10) {
                          return 'Invalid phone number.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: kCheckoutFormStyle),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: checkoutController.cityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'City cannot be empty.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'City', hintStyle: kCheckoutFormStyle),
              ),
              // TextFormField(
              //   controller: checkoutController.countryController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Country cannot be empty.';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //       hintText: 'Country', hintStyle: kCheckoutFormStyle),
              // ),

              TextFormField(
                controller: checkoutController.zipController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Zipcode cannot be empty.';
                  }
                  if (!GetUtils.isNumericOnly(value) || value.length != 6) {
                    return 'Invalid Zipcode.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'ZIP/Postcode', hintStyle: kCheckoutFormStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
