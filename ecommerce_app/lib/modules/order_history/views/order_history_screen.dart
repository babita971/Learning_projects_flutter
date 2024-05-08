// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/app_pages.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/firebase/firebase_database.dart';
import 'package:ecommerce_app/modules/dashboard/data/api_result.dart';
import 'package:ecommerce_app/modules/dashboard/modal/kicker_model.dart';
import 'package:ecommerce_app/modules/kicker_page/controller/kicker_screen_controller.dart';
import 'package:ecommerce_app/modules/order_history/controller/order_history_controller.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  OrderHistoryController orderHistoryController = Get.find();
  KickerScreenController kickerScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: getBackButton(context),
        titleSpacing: 0,
        centerTitle: true,
        title: const Text(
          'Order History',
          style: kAppBarTextStyle
        ),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
      ),
      // bottomNavigationBar: BottomNavigationBarView(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseOrderDatabase().fetchAllOrdersOfUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            orderHistoryController.hasOrders == true;
            // print('data is there ${snapshot.data!.docs.length}');
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> orderInfo = snapshot.data!.docs[index]
                    .data()! as Map<String, dynamic>;
                KickerModel order = ApiResult()
                    .getAllKickerModalsByID(orderInfo["kickerPid"]);
                var orderDate = DateTime.parse(
                        orderInfo["orderTime"].toDate().toString())
                    .toString()
                    .split(' ')[0];
                return GestureDetector(
                  onTap: () {
                    kickerScreenController.selectedKickerModal.value =
                        order;
                    Get.toNamed(Paths.PRODUCT_PAGE);
                  },
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          height: Get.height / 8,
                          width: Get.width / 3,
                          child:
                              Image(image: AssetImage(order.kickerImage)),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  order.kickerName,
                                  style: kCheckOutProductStyle,
                                ),
                                Text(
                                  'Qty : ${order.kickerQuantity.toString()}',
                                  style: kCheckOutProductStyleSmall,
                                ),
                                Text(
                                  '\$${order.kickerPrice.toString()}',
                                  style: kCheckOutProductStyleSmall,
                                ),
                                Text(
                                  'Ordered on $orderDate',
                                  style: kCheckOutProductStyleSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kContrastColor),
            ),
          );
        },
      ),
    );
  }
}
