// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartScreenController> {
  final CartScreenController cartController = Get.find();
  KickerScreenController kickerScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: getBackButton(context),
        titleSpacing: 0,
        centerTitle: true,
        title: Container(
          height: 40,
          child: Text(
            'Cart',
            style: kAppBarTextStyle,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
      ),
      body: Obx(
        () => cartController.productsInCart.isNotEmpty
            ? Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.productsInCart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Card(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset(cartController
                                          .productsInCart[index].kickerImage),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartController.productsInCart[index]
                                                .kickerName,
                                            style: kFontSize14DM,
                                          ),
                                          Text(
                                            '\$${cartController.productsInCart[index].kickerPrice}',
                                            style: kkickerPriceStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Total: \$${(cartController.productsInCart[index].kickerPrice * cartController.productsInCart[index].kickerQuantity).toStringAsFixed(2)}',
                                        style: kFontSize14DM,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Qty: ',
                                            style: kFontSize14DM,
                                          ),
                                          DropdownButton<String>(
                                            iconSize: 16,
                                            elevation: 0,
                                            // isExpanded: true,
                                            style: kBlackDMSansText,
                                            value: cartController
                                                .productsInCart[index]
                                                .kickerQuantity
                                                .toString(),
                                            onChanged: (String? newValue) {
                                              cartController
                                                  .changeProductQuantity(index,
                                                      int.parse(newValue!));
                                              cartController
                                                      .productsInCart[index]
                                                      .kickerQuantity =
                                                  int.parse(newValue);
                                            },
                                            items: <String>[
                                              '1',
                                              '2',
                                              '3',
                                              '4',
                                              '5'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              kickerScreenController
                                                  .updateAddToCartUI(
                                                      cartController
                                                              .productsInCart[
                                                          index]);
                                              cartController
                                                  .deleteProductToCart(
                                                      cartController
                                                              .productsInCart[
                                                          index]);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 16,
                                              color: kContrastColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  Container(
                    width: Get.width,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: RawMaterialButton(
                      fillColor: kContrastColor,
                      child: Text('Continue with checkout',
                          style: kWhiteDMSansText),
                      onPressed: () {
                        Get.toNamed(Paths.CHECKOUT);
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Image(
                    image: AssetImage('images/cart_empty.png'),
                  ),
                  Text(
                    'Cart is Empty.',
                    style: kUnselectedTabStyle,
                  ),
                ],
              ),
      ),
    );
  }
}
