import 'package:expense_tracker/expense/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; //To lock screen orientation

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 30, 30, 171),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 30, 30, 171),
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) {
    //Once lock the orientation then run runApp.
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.all(10),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.primaryContainer),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.onPrimary,
            iconTheme: const IconThemeData()
                .copyWith(size: 36, color: kColorScheme.onPrimary),
            titleTextStyle: const TextStyle()
                .copyWith(color: kColorScheme.onPrimary, fontSize: 22),
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.all(10),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontSize: 14,
                  color: kColorScheme.onSecondaryContainer,
                ),
                bodyLarge: TextStyle(
                    fontSize: 20, color: kColorScheme.onSecondaryContainer),
                bodySmall: TextStyle(
                    fontSize: 16, color: kColorScheme.onSecondaryContainer),
                bodyMedium: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kColorScheme.onSecondaryContainer),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MyApp(),
      ),
    );
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpensesPage();
  }
}
