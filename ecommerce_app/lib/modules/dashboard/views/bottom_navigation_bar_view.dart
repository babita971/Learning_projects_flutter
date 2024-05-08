// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/dashboard/controller/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarView extends GetView<BottomNavigationController> {
  @override
  final BottomNavigationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // ignore: prefer_const_literals_to_create_immutables
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Home 2.png'), size: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Heart 1.png'), size: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Notification 1.png'),
                    size: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/Bag 1.png'), size: 24),
                label: '',
              ),
            ],
            currentIndex: controller.currentIndex.value,
            selectedItemColor: kContrastColor,
            unselectedItemColor: kSecondaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: controller.changePage,
            backgroundColor: Colors.white),
      ),
      // ),
    );
  }
}
