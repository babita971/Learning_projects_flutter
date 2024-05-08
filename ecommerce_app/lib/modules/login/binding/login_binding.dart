import 'package:ecommerce_app/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }

}