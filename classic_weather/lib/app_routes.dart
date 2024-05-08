// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:sarcastic_weather/binding/home_binding.dart';
import 'package:sarcastic_weather/screens/home_page.dart';

class NamedRoutes {
  static const HOME = "/home-page";
}

class AppRoutes {
  static final PAGES = [
    GetPage(
      name: NamedRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    )
  ];
}
