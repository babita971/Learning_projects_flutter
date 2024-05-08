// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_pages.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      // appBar: AppBar(title: Text('Explore'),),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Center(
            child: CircleAvatar(
              radius: 150.0,
              backgroundImage: AssetImage('images/explore.jpg'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: const Text(
              'Crafted with Love Toy Store',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            child: const Text(
              'Let\'s explore your\n favourite toys and collect them\n all under the one roof.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              // ignore: sort_child_properties_last
              child: const Text(
                'Explore',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.offAllNamed(Paths.DASHBOARD);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
            ),
          ),
        ],
      ),
    );
  }
}
