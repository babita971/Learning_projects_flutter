import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/modules/dashboard/views/bottom_navigation_bar_view.dart';
import 'package:ecommerce_app/utils/util_widgets.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: getBackButton(context),
        titleSpacing: 0,
        centerTitle: true,
        title: SizedBox(height: 40, child: Image.asset('images/Kicker.png')),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
      ),
      body: Center(
        child: Container(
          color: kPrimaryColor,
          child: const Text('Notification Page'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarView(),
    );
  }
}
