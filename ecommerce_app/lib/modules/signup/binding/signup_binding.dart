import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:ecommerce_app/modules/signup/controller/signup_controller.dart';
import 'package:get/get.dart';

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<FirebaseAuthController>(() => FirebaseAuthController());
  }
}
