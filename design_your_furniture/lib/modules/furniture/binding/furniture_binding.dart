import 'package:design_your_furniture/modules/furniture/controller/furniture_controller.dart';
import 'package:get/get.dart';

class FurnitureBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(FurnitureController());
    Get.lazyPut<FurnitureController>(() => FurnitureController());
  }
}
