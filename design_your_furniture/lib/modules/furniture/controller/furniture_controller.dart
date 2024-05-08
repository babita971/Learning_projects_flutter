import 'package:design_your_furniture/data/furniture_data.dart';
import 'package:design_your_furniture/modal/furniture_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FurnitureController extends GetxController
    with GetTickerProviderStateMixin {
  var currentImageIndex = 0.obs;
  var index = Get.arguments;
  late ChairModel chairModel;
  late AnimationController controller;
  late Animation<double> titleAnimation;
  late Animation<double> tagAnimation;
  late Animation<double> priceAnimation;
  var isBasketPressed = false.obs;
  var isWishlistPressed = false.obs;

  @override
  void onInit() {
    chairModel = FurnitureData().getChairDataByIndex(index);
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this).obs();
    titleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.3),
      ),
    );
    tagAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 0.5),
      ),
    );
    priceAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.8),
      ),
    );

    controller.addListener(() {
      refresh();
    });
    controller.forward();
    super.onInit();
  }

  void goToPrevImage() {
    if (currentImageIndex > 0) {
      currentImageIndex--;
      controller.reset();
      controller.forward();
    } else {
      currentImageIndex.value = 0;
    }
  }

  void goToNextImage() {
    if (currentImageIndex < chairModel.chairImages.length - 1) {
      currentImageIndex++;
      controller.reset();
      controller.forward();
    } else {
      currentImageIndex = currentImageIndex;
    }
  }
}
