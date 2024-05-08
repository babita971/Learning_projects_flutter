import 'package:get/get.dart';
import 'package:minimalist_music_player/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
