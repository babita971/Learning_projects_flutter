import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:ecommerce_app/modules/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:ecommerce_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<KickerScreenController>(() => KickerScreenController());
    Get.put(CartScreenController());
  }
}
