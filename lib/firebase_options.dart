// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyhDo8cusZoZ0NBLLm5DypggXg_fRnjt8',
    appId: '1:1070373254732:android:68acaa37798b3e49bf26e9',
    messagingSenderId: '1070373254732',
    projectId: 'e-gaz-a839c',
    storageBucket: 'e-gaz-a839c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwdFsOrRrfwF4nQaHJw3R3riEqMRimjUY',
    appId: '1:1070373254732:ios:d925f32f4b2f8729bf26e9',
    messagingSenderId: '1070373254732',
    projectId: 'e-gaz-a839c',
    storageBucket: 'e-gaz-a839c.firebasestorage.app',
    iosBundleId: 'com.example.egaz',
  );

 
}