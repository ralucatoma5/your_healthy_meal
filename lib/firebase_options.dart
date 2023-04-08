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
    apiKey: 'AIzaSyCDsE1roXCx8Yj5KeJMhywlAB03l8RogwA',
    appId: '1:50797095584:web:2053830d0feb77268037c5',
    messagingSenderId: '50797095584',
    projectId: 'hackathon-3e987',
    authDomain: 'hackathon-3e987.firebaseapp.com',
    storageBucket: 'hackathon-3e987.appspot.com',
    measurementId: 'G-QREV2F4ZXD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1hil-7tqf71EjGPtPeQEElHwVhtz62gk',
    appId: '1:50797095584:android:bae6ed0e43f56ce38037c5',
    messagingSenderId: '50797095584',
    projectId: 'hackathon-3e987',
    storageBucket: 'hackathon-3e987.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCB-kXm7sERag9Ir7zAgurlmyOJmTyRch0',
    appId: '1:50797095584:ios:65adf38fd639c2608037c5',
    messagingSenderId: '50797095584',
    projectId: 'hackathon-3e987',
    storageBucket: 'hackathon-3e987.appspot.com',
    iosClientId: '50797095584-tnis4ja9erfbj30aabefgbo1vphgous0.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackathon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCB-kXm7sERag9Ir7zAgurlmyOJmTyRch0',
    appId: '1:50797095584:ios:65adf38fd639c2608037c5',
    messagingSenderId: '50797095584',
    projectId: 'hackathon-3e987',
    storageBucket: 'hackathon-3e987.appspot.com',
    iosClientId: '50797095584-tnis4ja9erfbj30aabefgbo1vphgous0.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackathon',
  );
}