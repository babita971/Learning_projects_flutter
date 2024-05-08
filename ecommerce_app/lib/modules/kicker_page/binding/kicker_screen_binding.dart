
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:get/get.dart';

class KickerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KickerScreenController>(() => KickerScreenController());
  }
}
