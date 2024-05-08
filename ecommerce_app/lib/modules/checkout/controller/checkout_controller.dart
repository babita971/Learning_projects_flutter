import 'dart:async';

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  var totalPrice = 0.0.obs;
  var subTotalPrice = 0.0.obs;
  final tax = 0.05; //Setting default tax as 5 %.
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();

  //Address
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();

  //Payment
  final cardNameController = TextEditingController();
  final cardNumController = TextEditingController();
  final expDateController = TextEditingController();
  final cvvController = TextEditingController();

  String cardName = 'empty'.obs();
  String cardNumber = 'empty'.obs();
  int expDay = 0.obs();
  int expMonth = 0.obs();
  int cvv = 0.obs();

  CartScreenController cartController = Get.find();
  KickerScreenController kickerScreenController = Get.find();

  @override
  void onInit() {
    super.onInit();
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    for (int i = 0; i < cartController.productsInCart.length; i++) {
      subTotalPrice.value += cartController.productsInCart[i].kickerPrice *
          cartController.productsInCart[i].kickerQuantity;
    }
    totalPrice.value = subTotalPrice.value + (subTotalPrice.value * tax);
  }

  void deleteAllItemsFromCart() {
    for (int i = 0; i < cartController.productsInCart.length; i++) {
      cartController.deleteProductToCart(cartController.productsInCart[i]);
    }
    totalPrice.value = 0;
    subTotalPrice.value = 0;
    kickerScreenController.resetSelectedKicker();
    cartController.productsInCart.clear();
    cartController.productsInCart.refresh;
    getAllOrdersDeletedDialog();
    Timer(const Duration(seconds: 1), () => {Get.offAllNamed(Paths.DASHBOARD)});
  }

  bool validateAddressForm() {
    if (addressFormKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  bool validatePaymentForm() {
    if (paymentFormKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
