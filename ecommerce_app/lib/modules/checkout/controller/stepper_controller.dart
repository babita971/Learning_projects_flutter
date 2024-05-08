// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/firebase/firebase_database.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
// import 'package:ecommerce_app/modules/order_history/controller/order_history_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:get/get.dart';

class StepperController extends GetxController {
  var index = 0.obs;
  var stepLength = 3; //Fixing the sections in checkout page.
  CheckoutScreenController checkoutController = Get.find();
  CartScreenController cartController = Get.find();

  void onInit() async {
    var addressInfo = await FirebaseOrderDatabase().fetchUserSavedAddress();
    if (!(addressInfo?.isEmpty ?? true)) {
      checkoutController.address1Controller.text =
          addressInfo['addressFirstLine'] ?? '';
      checkoutController.address2Controller.text =
          addressInfo['addressSecondLine'] ?? '';
      checkoutController.cityController.text = addressInfo['city'] ?? '';
      checkoutController.countryController.text = addressInfo['country'] ?? '';
      checkoutController.zipController.text = addressInfo['zip'] ?? '';
      checkoutController.phoneController.text = addressInfo['phone'] ?? '';
    }

    var cardInfo = await FirebaseOrderDatabase().fetchUserCardInfo();
    if (!(cardInfo?.isEmpty ?? true)) {
      checkoutController.cardNameController.text = cardInfo['cardName'] ?? '';
      checkoutController.cardNumController.text = cardInfo['cardNumber'] ?? '';
      checkoutController.expDateController.text =
          cardInfo['expirationDate'] ?? '';
      checkoutController.cvvController.text = cardInfo['cvv'] ?? '';
    }
  }

  void onStepCancelled() {
    index > 0 ? index -= 1 : null;
  }

  void onStepContinued() {
    if (index == 1) {
      if (checkoutController.validateAddressForm()) {
        FirebaseOrderDatabase().saveUserAddressToDatabase(
            addressFirstLine: checkoutController.address1Controller.text,
            addressSecondLine: checkoutController.address2Controller.text,
            city: checkoutController.cityController.text,
            country: checkoutController.countryController.text,
            zip: checkoutController.zipController.text,
            phone: checkoutController.phoneController.text);
        index < stepLength - 1 ? index += 1 : null;
      }
    } else if (index == 2) {
      if (checkoutController.validatePaymentForm()) {
        FirebaseOrderDatabase().saveUserCardInfoToDatabase(
          cardName: checkoutController.cardNameController.text,
          cardNumber: checkoutController.cardNumController.text,
          expirationDate: checkoutController.expDateController.text,
          cvv: checkoutController.cvvController.text,
        );
        index < stepLength - 1 ? index += 1 : null;
        getOrderPlacedDialog();
        saveOrdersToFirebaseDB();
        cartController.productsInCart.refresh;
        Timer(const Duration(seconds: 3), () {
          Get.offAllNamed(Paths.DASHBOARD);
        });
      }
    } else {
      index < stepLength - 1 ? index += 1 : null;
    }
  }

  void onStepTapped(int stepIndex) {
    index.value = stepIndex;
  }

  Future<void> saveOrdersToFirebaseDB() async {
    for (var i = 0; i < cartController.productsInCart.length; i++) {
      FirebaseOrderDatabase()
          .addPurchasedOrderToDB(kickerOrder: cartController.productsInCart[i]);
    }
  }
}
