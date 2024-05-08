import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimalist_music_player/app_routes.dart';
import 'package:minimalist_music_player/modules/home/binding/home_binding.dart';
import 'package:minimalist_music_player/modules/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minimalist music player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomePage(),
      getPages: Routes().pages,
        initialRoute: '/home',
    );
  }
}
