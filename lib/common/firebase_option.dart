// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyB2pL1OVR0-ETK6Rs1T-HuhqMDmQHyPcyI',
    appId: '1:186321810718:web:86d6577911c32012fe850f',
    messagingSenderId: '186321810718',
    projectId: 'dating-d6a6b',
    authDomain: 'dating-d6a6b.firebaseapp.com',
    storageBucket: 'dating-d6a6b.appspot.com',
    measurementId: 'G-72MMJRN2RS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZgDYLKRFoSvmdfkrMMYv5iQtpOM7zxb8',
    appId: '1:186321810718:android:d67b5ce5e88eb779fe850f',
    messagingSenderId: '186321810718',
    projectId: 'dating-d6a6b',
    storageBucket: 'dating-d6a6b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0YGU1fDeB1tNXEi6MTBlnA4q0ZWGt7hY',
    appId: '1:186321810718:ios:a54359d56bb93f11fe850f',
    messagingSenderId: '186321810718',
    projectId: 'dating-d6a6b',
    storageBucket: 'dating-d6a6b.appspot.com',
    androidClientId: '186321810718-g8dqiv0og1rh6kfrt8h2qc8dafnnbsp8.apps.googleusercontent.com',
    iosClientId: '186321810718-4oc4s3t1mhsjarnpoogg8gscf1rhun6g.apps.googleusercontent.com',
    iosBundleId: 'com.example.datingBuild',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0YGU1fDeB1tNXEi6MTBlnA4q0ZWGt7hY',
    appId: '1:186321810718:ios:a54359d56bb93f11fe850f',
    messagingSenderId: '186321810718',
    projectId: 'dating-d6a6b',
    storageBucket: 'dating-d6a6b.appspot.com',
    androidClientId: '186321810718-g8dqiv0og1rh6kfrt8h2qc8dafnnbsp8.apps.googleusercontent.com',
    iosClientId: '186321810718-4oc4s3t1mhsjarnpoogg8gscf1rhun6g.apps.googleusercontent.com',
    iosBundleId: 'com.example.datingBuild',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB2pL1OVR0-ETK6Rs1T-HuhqMDmQHyPcyI',
    appId: '1:186321810718:web:3cb84709e7c696b7fe850f',
    messagingSenderId: '186321810718',
    projectId: 'dating-d6a6b',
    authDomain: 'dating-d6a6b.firebaseapp.com',
    storageBucket: 'dating-d6a6b.appspot.com',
    measurementId: 'G-HVQH00ZXH9',
  );
}