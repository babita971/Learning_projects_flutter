import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/modules/checkout/controller/stepper_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutScreenController>(() => CheckoutScreenController());
    Get.lazyPut<StepperController>(() => StepperController());
  }
}
