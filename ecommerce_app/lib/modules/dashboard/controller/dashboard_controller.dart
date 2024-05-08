// ignore_for_file: prefer_const_constructors
import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/firebase/firebase_auth.dart';
import 'package:ecommerce_app/modules/dashboard/data/api_result.dart';
import 'package:ecommerce_app/modules/dashboard/modal/kicker_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController
    with SingleGetTickerProviderMixin {
  ApiResult apiResult = ApiResult();
  late TabController categoryTabsController;
  var selectedKickerModal = KickerModel().obs;
  final FirebaseAuthController firebaseController = Get.find();

  final List<Tab> categoryTabs = <Tab>[
    Tab(
      text: 'Explore',
    ),
    Tab(
      text: 'Popular',
    ),
    Tab(
      text: 'Newest Deals',
    ),
    Tab(
      text: 'High ratings',
    )
  ];

  @override
  void onInit() async {
    categoryTabsController =
        TabController(length: categoryTabs.length, vsync: this);
    super.onInit();
  }

  void signOutUser() {
    firebaseController.signOutUser();
    Get.offAllNamed(Paths.SPLASH_SCREEN);
  }
}
