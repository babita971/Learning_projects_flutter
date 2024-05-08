// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:ecommerce_app/app_pages.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;

  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    generateRoute();
  }

  generateRoute() {
    if (currentIndex.value == 0)
      return Get.toNamed(Paths.DASHBOARD);
    else if (currentIndex.value == 1)
      return Get.toNamed(Paths.WISHLIST);
    else if (currentIndex.value == 2)
      return Get.toNamed(Paths.NOTIFICATIONS);
    else if (currentIndex.value == 3)
      return Get.toNamed(Paths.CART);
    else
      return 0;
  }
}
