// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:math';

import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/dashboard/views/bottom_navigation_bar_view.dart';
import 'package:ecommerce_app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:numeral/numeral.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class DashBoard extends GetView<DashboardController> {
  final DashboardController dashboardController = Get.find();
  final KickerScreenController kickerScreenController = Get.find();

  Widget createKickerGridView() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (Get.width / 3) / (Get.height / 4),
      padding: EdgeInsets.symmetric(horizontal: 8),
      children: dashboardController.apiResult
          .getAllKickerModals()
          .map<Widget>((kickerModal) {
        return GestureDetector(
          onTap: () {
            kickerScreenController.selectedKickerModal.value = kickerModal;
            Get.toNamed(Paths.PRODUCT_PAGE);
          },
          child: Card(
            color: kPrimaryColor,
            elevation: 0,
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Image(
                      image: AssetImage(kickerModal.kickerImage),
                      fit: BoxFit.contain),
                ),
                Expanded(
                  child: Text(
                    kickerModal.kickerName,
                    // textAlign: TextAlign.start,
                    style: kFontSize16DM,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${kickerModal.kickerPrice.toString().split('.')[0]}',
                          style: kkickerPriceStyle,
                        ),
                        Text(kickerModal.kickerPrice.toString().split('.')[1],
                            style: kkickerPriceSuperStyle),
                        Spacer(),
                        reviewImagesWidget()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      '${Numeral(kickerModal.kickerSales).format().toString()} people bought this',
                      style: TextStyle(
                        fontSize: 12,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: RatingBarIndicator(
                        rating: kickerModal.kickerStars,
                        itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        itemCount: 5,
                        itemSize: 14.0,
                        direction: Axis.horizontal),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: SizedBox(height: 40, child: Image.asset('images/Kicker.png')),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
        actions: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Image(
              image: AssetImage('images/profile.png'),
              width: 32,
              height: 32,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image(
                image: AssetImage('images/Kicker.png'),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Get.toNamed(Paths.PROFILE);
              },
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                Get.toNamed(Paths.CART);
              },
            ),
            ListTile(
              title: const Text('Order History'),
              onTap: () {
                Get.toNamed(Paths.ORDER_HISTORY);
              },
            ),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {
                dashboardController.signOutUser();
              },
            ),
          ],
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
            width: double.infinity,
            height: 40,
            child: const Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'e.g Nike Air Jordans',
                  hintStyle: kTextFormStyle,
                  suffixIcon: Icon(Icons.search, color: Color(0xFF979797)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFA4A4A4), width: 0.5),
            ),
          ),
          TabBar(
              controller: dashboardController.categoryTabsController,
              tabs: dashboardController.categoryTabs,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: DotIndicator(
                color: kContrastColor,
                distanceFromCenter: 16,
                radius: 3,
                paintingStyle: PaintingStyle.fill,
              ),
              // indicator: CircleTabIndicator(color: Colors.green, radius: 4),
              labelStyle: kSelectedTabStyle,
              unselectedLabelStyle: kTextFormStyle,
              isScrollable: true),
          Expanded(
            child: TabBarView(
              controller: dashboardController.categoryTabsController,
              children: [
                createKickerGridView(),
                createKickerGridView(),
                createKickerGridView(),
                createKickerGridView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: kContrastColor,
        onPressed: () {},
        child: Image.asset('images/Scan 10.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBarView(),
    );
  }
}

Widget reviewImagesWidget() {
  const overlap = 15.0;

  String getRandomImage() {
    var random = Random().nextInt(8) + 1;
    return random.toString();
  }

  final items = [
    Image.asset('images/Ellipse${getRandomImage()}.png'),
    Image.asset('images/Ellipse${getRandomImage()}.png'),
    Image.asset('images/Ellipse${getRandomImage()}.png'),
  ];

  List<Widget> stackLayers = List<Widget>.generate(items.length, (index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
      child: items[index],
    );
  });

  return Stack(children: stackLayers);
}
