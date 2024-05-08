import 'package:ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:ecommerce_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:ecommerce_app/modules/order_history/controller/order_history_controller.dart';
import 'package:get/get.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderHistoryController());
    Get.lazyPut<CheckoutScreenController>(() => CheckoutScreenController());
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
