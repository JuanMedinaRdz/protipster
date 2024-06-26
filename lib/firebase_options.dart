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
    apiKey: 'AIzaSyBgQkM6pVLTPRcYEMnI-Rqnxpwafu_2who',
    appId: '1:666783981570:web:b78d4ca8ecd5331aa4071b',
    messagingSenderId: '666783981570',
    projectId: 'appjacc-ce47a',
    authDomain: 'appjacc-ce47a.firebaseapp.com',
    storageBucket: 'appjacc-ce47a.appspot.com',
    measurementId: 'G-THPLR5W05D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfd2JIqi1A2FuOVgk4ry-vZgN1RUWQ3-s',
    appId: '1:666783981570:android:789393d95e4eb72ca4071b',
    messagingSenderId: '666783981570',
    projectId: 'appjacc-ce47a',
    storageBucket: 'appjacc-ce47a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQVJcFhuGrECfsbuknftieVdzK69ej46w',
    appId: '1:666783981570:ios:fb2a9ec409f9e27ba4071b',
    messagingSenderId: '666783981570',
    projectId: 'appjacc-ce47a',
    storageBucket: 'appjacc-ce47a.appspot.com',
    iosBundleId: 'com.example.protipster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQVJcFhuGrECfsbuknftieVdzK69ej46w',
    appId: '1:666783981570:ios:fb2a9ec409f9e27ba4071b',
    messagingSenderId: '666783981570',
    projectId: 'appjacc-ce47a',
    storageBucket: 'appjacc-ce47a.appspot.com',
    iosBundleId: 'com.example.protipster',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBgQkM6pVLTPRcYEMnI-Rqnxpwafu_2who',
    appId: '1:666783981570:web:7b99960fde5a5adaa4071b',
    messagingSenderId: '666783981570',
    projectId: 'appjacc-ce47a',
    authDomain: 'appjacc-ce47a.firebaseapp.com',
    storageBucket: 'appjacc-ce47a.appspot.com',
    measurementId: 'G-4FW22ZQWYK',
  );
}
