import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/meals_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 183, 26, 26),
  ),
  textTheme: GoogleFonts.latoTextTheme().copyWith(
    headlineMedium: const TextStyle(
        fontSize: 24, color: Colors.orange, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(
        fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
    bodySmall: const TextStyle(fontSize: 16, color: Colors.white),
  ),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: const MealsHomePage(),
    );
  }
}


//Category main opening page with gridview builder. You can switch with tab here with all meals and favourite ones.
//On click to category go to another page to view all food items in that specific category in linear fashion. List.
//On click to each food item, go to the food page where it has its image and recipe and ingredients. You can also mark food item as favourite or vice-versa.
//Drawer with filters to set on meals
//Empty screen when no meals under filters or favourite.
//2 tabs, 3 individual screens + filters screen, data to hold all meals and favourited meals.