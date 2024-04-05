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
    apiKey: 'AIzaSyCfo0Qyb4vFq6JH8GVQuT63Q78Lz79DiG8',
    appId: '1:327941159644:web:4f016583976a6fe2e35219',
    messagingSenderId: '327941159644',
    projectId: 'mobileebiz-fd005',
    authDomain: 'mobileebiz-fd005.firebaseapp.com',
    storageBucket: 'mobileebiz-fd005.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6crWB3xz7-rwwP10KHdQUqSMwzjUU7oQ',
    appId: '1:327941159644:android:af880eee4e24489ce35219',
    messagingSenderId: '327941159644',
    projectId: 'mobileebiz-fd005',
    storageBucket: 'mobileebiz-fd005.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbWvFLpWb4fzdv34c2eoITHybrugFEqvQ',
    appId: '1:327941159644:ios:1876f10527017297e35219',
    messagingSenderId: '327941159644',
    projectId: 'mobileebiz-fd005',
    storageBucket: 'mobileebiz-fd005.appspot.com',
    iosBundleId: 'com.sinokor.mobileEbiz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbWvFLpWb4fzdv34c2eoITHybrugFEqvQ',
    appId: '1:327941159644:ios:c993dafc5ebaaa08e35219',
    messagingSenderId: '327941159644',
    projectId: 'mobileebiz-fd005',
    storageBucket: 'mobileebiz-fd005.appspot.com',
    iosBundleId: 'com.example.mobileEbiz.RunnerTests',
  );
}
