// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';

class KickerPage extends GetView<KickerScreenController> {
  final CartScreenController cartController = Get.find();
  final KickerScreenController kickerScreenController = Get.find();
  final overlap = 30.0;
  var reviewImages = [];

  KickerPage() {
    reviewImages = [
      Image.asset('images/product3.png'),
      Image.asset('images/product2.png'),
      Image.asset('images/product4.png'),
      CircleAvatar(
        backgroundColor: Color(0xFFE8E8E8),
        child: Text(
          '+${Numeral(kickerScreenController.selectedKickerModal.value.kickerSales).format()}',
          style: TextStyle(
              fontFamily: 'DM Sans', fontSize: 10, color: kSecondaryColor),
        ),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: Image.asset('images/Purchase.png'),
        ),
        leading: getBackButton(context),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
        actions: <Widget>[
          GestureDetector(
            onTap: (() {
              Get.toNamed(Paths.CART);
            }),
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image(
                image: AssetImage('images/Bag 1.png'),
                width: 32,
                height: 32,
              ),
            ),
          )
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: Get.height / 2.5,
              width: double.infinity,
              child: Image(
                  filterQuality: FilterQuality.high,
                  image: AssetImage(kickerScreenController
                      .selectedKickerModal.value.kickerImage),
                  fit: BoxFit.fill),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                kickerScreenController.selectedKickerModal.value.kickerName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'DM Sans'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                  kickerScreenController
                      .selectedKickerModal.value.kickerDescription,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                      color: kSecondaryColor)),
            ),
            Row(
              children: [
                Stack(
                  children: List<Widget>.generate(
                    reviewImages.length,
                    (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              index.toDouble() * overlap, 0, 0, 0),
                          child: reviewImages[index],
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                            rating: kickerScreenController
                                .selectedKickerModal.value.kickerStars,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal),
                        Text(
                          kickerScreenController
                              .selectedKickerModal.value.kickerStars
                              .toString(),
                          style: kUnselectedTabStyle,
                        )
                      ],
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Colors available',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  colorsAvailableWidget(),
                  Spacer(),
                  Text(
                    '\$${kickerScreenController.selectedKickerModal.value.kickerPrice.toString().split('.')[0]}',
                    style: kkickerPriceStyleBig,
                  ),
                  Text(
                      kickerScreenController
                          .selectedKickerModal.value.kickerPrice
                          .toString()
                          .split('.')[1],
                      style: kkickerPriceSuperStyleBig),
                ],
              ),
            ),
            Spacer(),
            Obx(
              () {
                return Container(
                  height: Get.height / 10,
                  decoration: BoxDecoration(
                    color: kickerScreenController
                                .selectedKickerModal.value.isAddedToCart ==
                            true
                        ? kContrastColor
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: RawMaterialButton(
                    onPressed: () {
                      kickerScreenController.itemAddedToCartCallback();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          kickerScreenController.selectedKickerModal.value
                                      .isAddedToCart ==
                                  true
                              ? 'Added to Cart '
                              : 'Add to Cart ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DM Sans'),
                        ),
                        kickerScreenController
                                    .selectedKickerModal.value.isAddedToCart ==
                                true
                            ? Icon(Icons.check_circle)
                            : ImageIcon(
                                AssetImage('images/Bag 1.png'),
                                color: Colors.black,
                                size: 16,
                              )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarView(),
    );
  }

  colorsAvailableWidget() {
    List<Widget> productColors = [];
    for (var i = 0;
        i <
            kickerScreenController
                .selectedKickerModal.value.kickerAvailableColors.length;
        i++) {
      productColors.add(
        Container(
          margin: EdgeInsets.only(right: 2),
          child: CircleAvatar(
            backgroundColor: kickerScreenController
                .selectedKickerModal.value.kickerAvailableColors[i],
            radius: 15,
          ),
        ),
      );
    }
    return Row(
      children: productColors,
    );
  }
}
