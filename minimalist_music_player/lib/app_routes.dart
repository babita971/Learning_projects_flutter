import 'package:get/get.dart';
import 'package:minimalist_music_player/modules/home/binding/home_binding.dart';
import 'package:minimalist_music_player/modules/home/views/home_view.dart';

class Routes {
  List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    )
  ];
}
