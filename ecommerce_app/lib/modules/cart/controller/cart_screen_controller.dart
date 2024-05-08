// ignore_for_file: unused_import

import 'package:ecommerce_app/modules/dashboard/modal/kicker_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  var productsInCart = <KickerModel>[].obs;

  void addProductToCart(KickerModel product) {
    if (productsInCart.isEmpty) {
      productsInCart.add(product);
    } else {
      var itemCheck = true;
      for (var i = 0; i < productsInCart.length; i++) {
        if (product.kickerPid == productsInCart[i].kickerPid) {
          productsInCart[i].kickerQuantity++;
          itemCheck = false;
          break;
        }
      }
      if (itemCheck == true) {
        productsInCart.add(product);
        // Only add if item do not already exists in cart.
      }
    }
    // Get.offNamed(Paths.CART);
    Get.snackbar(
      'Yay!',
      'Kicker added to cart!',
      duration: const Duration(seconds: 1),
    );
  }

  bool checkItemInCart(KickerModel product) {
    bool itemInCart = false;
    for (var i = 0; i < productsInCart.length; i++) {
      if (product.kickerPid == productsInCart[i].kickerPid) {
        productsInCart[i].kickerQuantity++;
        itemInCart = true;
        break;
      }
    }
    return itemInCart;
  }

  void deleteProductToCart(KickerModel product) {
    productsInCart.removeWhere((item) => item.kickerPid == product.kickerPid);
    productsInCart.refresh();
  }

  void changeProductQuantity(int index, int updatedQuantity) {
    productsInCart[index].kickerQuantity = updatedQuantity;
    productsInCart.refresh();
  }
}
