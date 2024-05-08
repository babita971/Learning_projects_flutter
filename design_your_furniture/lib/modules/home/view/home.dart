// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:design_your_furniture/app_pages.dart';
import 'package:design_your_furniture/constants.dart';
import 'package:design_your_furniture/data/furniture_data.dart';
import 'package:design_your_furniture/modal/furniture_modal.dart';
import 'package:design_your_furniture/modules/home/controller/home_controller.dart';
import 'package:design_your_furniture/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomeController homeController = Get.find();
  List<ChairModel> furnitureStore = FurnitureData().getAllFurnitureData();

  Widget buildCustomAppBar() {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          icon: const Icon(CustomIcons.menu, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(CustomIcons.search, color: Colors.black),
          onPressed: () {},
        ),
      ]),
    );
  }

  Widget buildGradientBackground(double width, double height) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: width * 0.8,
        height: height / 2,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kGradientColor1, kGradientColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 1.0],
          ),
        ),
      ),
    );
  }

  Widget buildCustomAppTitle(height) {
    return Positioned(
      top: height * 0.2,
      left: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Wooden Armchair",
            style: TextStyle(
              fontSize: 28,
              fontFamily: "Montserrat-Bold",
            ),
          ),
          const Text(
            "Explore our wide range of lounge chairs.",
            style: TextStyle(fontSize: 14, fontFamily: "Montserrat-Medium"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return

        // Obx(
        //   () =>
        Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;
          return Stack(
            fit: StackFit.expand,
            children: [
              buildGradientBackground(width, height),
              buildCustomAppBar(),
              buildCustomAppTitle(height),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    itemCount: furnitureStore.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppPages.FURNITURE_VIEW, arguments: index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35, bottom: 60),
                          child: SizedBox(
                            width: 200,
                            child: Stack(fit: StackFit.expand, children: [
                              Padding(
                                padding: EdgeInsets.only(top: 45),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Color(0xFF2a2d3f),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0.0, 10.0),
                                          blurRadius: 10),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(furnitureStore[index].chairPreview,
                                      width: width * 3,
                                      height: height / 4,
                                      fit: BoxFit.cover),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          furnitureStore[index].chairName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Montserrat-Bold",
                                              color: (index % 2 == 0)
                                                  ? Color(0xFF2a2d2f)
                                                  : Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "NEW SELL",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Montserrat-Medium",
                                              color: (index % 2 == 0)
                                                  ? Color(0xFF2a2d3f)
                                                  : Colors.white),
                                        ),
                                        SizedBox(
                                            // height: 50.0,
                                            ),
                                        Text(
                                            "${furnitureStore[index]
                                                    .chairPrice} \$",
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                fontFamily: "Montserrat-Bold",
                                                color: (index % 2 == 0)
                                                    ? Color(0xFF2a2d3f)
                                                    : Colors.white))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF7686AC),
        unselectedItemColor: Color(0xFFA4B1CC),
        onTap: (index) {
          homeController.updateCurrentIndex(index);
        },
        currentIndex: homeController.currentIndex,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.panorama_horizontal),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.bookmark_border),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 65.0,
        height: 65.0,
        decoration: BoxDecoration(
            color: Color(0xFFfa7b58),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFf78a6c).withOpacity(.6),
                  offset: Offset(0.0, 10.0),
                  blurRadius: 10.0)
            ]),
        child: RawMaterialButton(
          shape: CircleBorder(),
          child: Icon(
            Icons.add,
            size: 35.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ),
    );
  }
}
