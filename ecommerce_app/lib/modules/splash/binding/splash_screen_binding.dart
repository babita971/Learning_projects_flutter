import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:ecommerce_app/modules/splash/controller/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SplashController>(() => SplashController());
    Get.put(SplashController());
    Get.put(FirebaseAuthController());
  }
}
