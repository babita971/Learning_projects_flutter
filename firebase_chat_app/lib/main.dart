import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/screens/chat_page.dart';
import 'package:firebase_chat_app/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var list = [5, 1, 22, 25, 6, -1, 8, 10];
  var target = [5, 1, 32, 25, 6, -1, 8, 10];
  var count = 0;
  int pointer = 0;
  for (int i = 0; i < list.length; i++) {
    if (target[pointer] == list[i]) {
      //match found
      pointer += 1;
      count += 1;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatPage();
            }
            return const SignInPage();
          }),
    );
  }
}
