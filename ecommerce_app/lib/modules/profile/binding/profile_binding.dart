import 'package:ecommerce_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:ecommerce_app/modules/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
