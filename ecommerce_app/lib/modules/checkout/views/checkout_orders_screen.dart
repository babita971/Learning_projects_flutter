// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TotalOrderScreen extends GetView<CheckoutScreenController> {
  CheckoutScreenController checkoutController = Get.find();
  CartScreenController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: kBoldCheckoutStyle,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${cartController.productsInCart.length.toString()} items(s)',
                  style: ksecondaryDMSansText
                ),
              ),
              IconButton(
                onPressed: () {
                  checkoutController.deleteAllItemsFromCart();
                },
                icon: Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Divider(
            color: kSecondaryColor,
            height: 10,
            thickness: 0.3,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: cartController.productsInCart.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: Get.height / 10,
                      width: Get.width / 4,
                      child: Image(
                        image: AssetImage(
                            cartController.productsInCart[index].kickerImage),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              cartController.productsInCart[index].kickerName,
                              style: kCheckOutProductStyle,
                            ),
                            Text(
                              'Qty : ${cartController.productsInCart[index].kickerQuantity.toString()}',
                              style: kCheckOutProductStyleSmall,
                            ),
                            Text(
                              '\$${cartController.productsInCart[index].kickerPrice.toString()}',
                              style: kCheckOutProductStyleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(
            color: kSecondaryColor,
            height: 10,
            thickness: 0.3,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Subtotal',
                style: kCheckOutProductStyleSmall,
              )),
              Text(
                '\$${checkoutController.subTotalPrice.value.toStringAsFixed(2)}',
                style: kCheckOutProductStyleSmall,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Tax',
                style: kCheckOutProductStyleSmall,
              )),
              Text(
                '\$${(checkoutController.subTotalPrice.value * checkoutController.tax).toStringAsFixed(2)}',
                style: kCheckOutProductStyleSmall,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 10),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Total',
                  style: kCheckOutProductStyle,
                )),
                Text(
                  '\$${checkoutController.totalPrice.value.toStringAsFixed(2)}',
                  style: kCheckOutProductStyle,
                ),
              ],
            ),
          ),
          Divider(
            color: kSecondaryColor,
            height: 10,
            thickness: 0.3,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Payment Mode', style: kBoldCheckoutStyle),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(FontAwesomeIcons.buildingColumns, size: 18),
              ),
              Expanded(
                child: Tooltip(
                  message: 'Bank services not reachable currently.',
                  child: Text('Bank Transfer', style: kCheckoutPayStyle),
                ),
              ),
              Radio(
                toggleable: false,
                fillColor: MaterialStateProperty.all(
                  Colors.grey,
                ),
                value: 0,
                groupValue: 1,
                onChanged: (int? value) {},
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(FontAwesomeIcons.creditCard, size: 18),
              ),
              Expanded(
                child: Tooltip(
                  message: 'Please pay through your credit card.',
                  child: Text('Card Payment', style: kCheckoutPayStyle),
                ),
              ),
              Radio(
                toggleable: false,
                fillColor: MaterialStateProperty.all(
                  Colors.black,
                ),
                value: 0,
                groupValue: 0,
                onChanged: (int? value) {},
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(FontAwesomeIcons.coins, size: 18),
              ),
              Expanded(
                child: Tooltip(
                  message: 'Crypto services not reachable currently.',
                  child: Text('Pay with Crypto using Petra',
                      style: kCheckoutPayStyle),
                ),
              ),
              Radio(
                toggleable: false,
                fillColor: MaterialStateProperty.all(
                  Colors.grey,
                ),
                value: 0,
                groupValue: 1,
                onChanged: (int? value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
