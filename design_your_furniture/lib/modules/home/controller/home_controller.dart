import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0.obs();

  void updateCurrentIndex(int index) {
    currentIndex = index;
  }
}
