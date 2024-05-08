// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:design_your_furniture/constants.dart';
import 'package:design_your_furniture/modules/furniture/controller/furniture_controller.dart';
import 'package:design_your_furniture/widgets/custom_icon.dart';
import 'package:design_your_furniture/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FurniturePage extends GetView<FurnitureController> {
  FurnitureController furnitureController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          // backgroundColor: Color(0xFF2a2d2f),
          body: Stack(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60)),
                    child: SizedBox(
                      height: Get.height * .7,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                              furnitureController.chairModel.chairImages[
                                  furnitureController.currentImageIndex.value],
                              fit: BoxFit.cover),
                          Positioned(
                            top: 40,
                            left: 20,
                            child: IconButton(
                              color: Colors.black,
                              icon: const Icon(CustomIcons.back),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 35,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.translate(
                                    offset: Offset(
                                      0.0,
                                      30 *
                                          (1 -
                                              furnitureController
                                                  .titleAnimation.value),
                                    ),
                                    child: Opacity(
                                      opacity: furnitureController
                                          .titleAnimation.value,
                                      child: Text(
                                        furnitureController
                                            .chairModel.chairName,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: "Montserrat-Bold"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Transform.translate(
                                    offset: Offset(
                                      0.0,
                                      20 *
                                          (1 -
                                              furnitureController
                                                  .tagAnimation.value),
                                    ),
                                    child: Opacity(
                                      opacity: furnitureController
                                          .tagAnimation.value,
                                      child: Text(
                                        furnitureController
                                            .chairModel.chairSubTitle
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Opacity(
                                    opacity: furnitureController
                                        .priceAnimation.value,
                                    child: Text(
                                      furnitureController.chairModel.chairPrice
                                              .toString() +
                                          " \$",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: "Montserrat-Bold"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: PageIndicator(
                                        furnitureController
                                            .currentImageIndex.value,
                                        furnitureController
                                            .chairModel.chairImages.length),
                                  ),
                                ]),
                          ),
                          Positioned.fill(
                            child: GestureDetector(
                                onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.velocity.pixelsPerSecond.dx > 0) {
                                furnitureController.goToPrevImage();
                                // furnitureController.currentImageIndex =
                                //     furnitureController.currentImageIndex;
                              } else if (details.velocity.pixelsPerSecond.dx <
                                  0) {
                                furnitureController.goToNextImage();
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wooden Dining Chairs',
                          style: TextStyle(
                              fontSize: 28, fontFamily: 'Montserrat-Bold'),
                        ),
                        SizedBox(height: 5),
                        Text(
                          furnitureController.chairModel.description,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                  ),
                  child: SizedBox(
                    width: 160,
                    height: 60,
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          color: !furnitureController.isWishlistPressed.value
                              ? kHeartBgActiveColor
                              : Colors.white,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                furnitureController.isWishlistPressed.value =
                                    furnitureController.isWishlistPressed.value
                                        ? false
                                        : true;

                                if (furnitureController
                                    .isWishlistPressed.value) {
                                  Get.snackbar('Yay!',
                                      '${furnitureController.chairModel.chairName} is added to wishlist!',
                                      backgroundColor: Colors.white);
                                } else {
                                  Get.snackbar(
                                    'Oh No!',
                                    '${furnitureController.chairModel.chairName} is removed from wishlist!',
                                    backgroundColor: Colors.white,
                                    duration: Duration(seconds: 1),
                                  );
                                }
                              },
                              icon: Icon(
                                  !furnitureController.isWishlistPressed.value
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: furnitureController
                                          .isWishlistPressed.value
                                      ? kHeartBgActiveColor
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: !furnitureController.isBasketPressed.value
                              ? kBasketBgActiveColor
                              : Colors.white, //Colors.white,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                furnitureController.isBasketPressed.value =
                                    furnitureController.isBasketPressed.value
                                        ? false
                                        : true;
                                if (furnitureController.isBasketPressed.value) {
                                  Get.snackbar('Yay!',
                                      '${furnitureController.chairModel.chairName} is added to cart!',
                                      backgroundColor: Colors.white);
                                } else {
                                  Get.snackbar(
                                    'Oh No!',
                                    '${furnitureController.chairModel.chairName} is removed from cart!',
                                    backgroundColor: Colors.white,
                                    duration: Duration(seconds: 1),
                                  );
                                }
                              },
                              icon: Icon(
                                  !furnitureController.isBasketPressed.value
                                      ? Icons.shopping_basket_outlined
                                      : Icons.shopping_basket,
                                  color:
                                      furnitureController.isBasketPressed.value
                                          ? kBasketBgActiveColor
                                          : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
