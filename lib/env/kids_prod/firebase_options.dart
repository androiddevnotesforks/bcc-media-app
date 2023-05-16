// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyChwMm2G7CtTr7QNNDrR6fOISuSx0JwZpM',
    appId: '1:617519323732:web:4ddc13f0402b3a2d89ebc1',
    messagingSenderId: '617519323732',
    projectId: 'btv-platform-prod-2',
    storageBucket: 'btv-platform-prod-2.appspot.com',
    measurementId: 'G-385FC6FYFN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIie1N55IWsXPLupVCMuSGhdY-YPJ2V5o',
    appId: '1:617519323732:android:c044a67e0b46ece089ebc1',
    messagingSenderId: '617519323732',
    projectId: 'btv-platform-prod-2',
    storageBucket: 'btv-platform-prod-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCV5dcov2D9S2b9wjTzkKDQRTWnqMUhcAU',
    appId: '1:617519323732:ios:66c2b6796bb6e59689ebc1',
    messagingSenderId: '617519323732',
    projectId: 'btv-platform-prod-2',
    storageBucket: 'btv-platform-prod-2.appspot.com',
    iosClientId: '617519323732-lkdhqa2vj63tmgq8h87g3o2tcdm3nosn.apps.googleusercontent.com',
    iosBundleId: 'tv.brunstad.app',
  );
}