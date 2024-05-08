import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/dashboard/views/bottom_navigation_bar_view.dart';
import 'package:ecommerce_app/modules/profile/controller/profile_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    // print(profileController.profileData);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: getBackButton(context),
        titleSpacing: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: kAppBarTextStyle,
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hi, ${profileController.profileData.displayName?.split(' ')[0]}',
            textAlign: TextAlign.center,
            // ignore: prefer_const_constructors
            style: kBigActoniaTextStyle
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarView(),
    );
  }
}

//  Container(
//             margin: const EdgeInsets.all(20),
//             height: Get.height / 3,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               // color: kContrastColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child:Text(
//             'Hi, ${profileController.profileData.displayName}',
//             textAlign: TextAlign.center,
//             style:
//           ),
 