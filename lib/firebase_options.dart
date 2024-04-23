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
    apiKey: 'AIzaSyCu707qmNDulj8bB6hLX-S4l_ls7L1mbWQ',
    appId: '1:18502640115:web:6b394afd21b052f5a1b286',
    messagingSenderId: '18502640115',
    projectId: 'placarteste-f3d3f',
    authDomain: 'placarteste-f3d3f.firebaseapp.com',
    databaseURL: 'https://placarteste-f3d3f-default-rtdb.firebaseio.com',
    storageBucket: 'placarteste-f3d3f.appspot.com',
    measurementId: 'G-4VHYCHDH69',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDxxT35nu6DoidikMpza6n_c339J-8Dis',
    appId: '1:18502640115:android:a036a82dcbe85eeea1b286',
    messagingSenderId: '18502640115',
    projectId: 'placarteste-f3d3f',
    databaseURL: 'https://placarteste-f3d3f-default-rtdb.firebaseio.com',
    storageBucket: 'placarteste-f3d3f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpS-_Q4-MLssiInFPJn80ielZP8Oy3CLg',
    appId: '1:18502640115:ios:5583df3623965a84a1b286',
    messagingSenderId: '18502640115',
    projectId: 'placarteste-f3d3f',
    databaseURL: 'https://placarteste-f3d3f-default-rtdb.firebaseio.com',
    storageBucket: 'placarteste-f3d3f.appspot.com',
    iosBundleId: 'com.example.placarApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpS-_Q4-MLssiInFPJn80ielZP8Oy3CLg',
    appId: '1:18502640115:ios:772c6df8517bb963a1b286',
    messagingSenderId: '18502640115',
    projectId: 'placarteste-f3d3f',
    databaseURL: 'https://placarteste-f3d3f-default-rtdb.firebaseio.com',
    storageBucket: 'placarteste-f3d3f.appspot.com',
    iosBundleId: 'com.example.placarApp.RunnerTests',
  );
}
