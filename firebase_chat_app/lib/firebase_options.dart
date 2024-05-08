// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBq_Jf2kspLYNaDPYdPqU0QEcPb7pcGwg4',
    appId: '1:233121755614:web:54e5719074bb950b36ed4f',
    messagingSenderId: '233121755614',
    projectId: 'group-chat-app1',
    authDomain: 'group-chat-app1.firebaseapp.com',
    storageBucket: 'group-chat-app1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEv22OFv5I9QYREGd9J2soEz_NBeFxM14',
    appId: '1:233121755614:android:11db7eede56237c036ed4f',
    messagingSenderId: '233121755614',
    projectId: 'group-chat-app1',
    storageBucket: 'group-chat-app1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqfMyVb4AXL4WmUDVUPI11TYDFaoTGLP8',
    appId: '1:233121755614:ios:6f8cca0b6de395e936ed4f',
    messagingSenderId: '233121755614',
    projectId: 'group-chat-app1',
    storageBucket: 'group-chat-app1.appspot.com',
    iosClientId: '233121755614-24uhsvi8gkqhtniqcjbp28lkn2e70qdl.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqfMyVb4AXL4WmUDVUPI11TYDFaoTGLP8',
    appId: '1:233121755614:ios:e358bceb75c473fd36ed4f',
    messagingSenderId: '233121755614',
    projectId: 'group-chat-app1',
    storageBucket: 'group-chat-app1.appspot.com',
    iosClientId: '233121755614-93t9mpbne7jb6cm9uf5ss2eni1nbom98.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseChatApp.RunnerTests',
  );
}