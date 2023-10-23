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
    apiKey: 'AIzaSyBc9BD88j9xU9i2cfLcJ6Y36Rt70CgeiBE',
    appId: '1:448618094949:web:efe9d75e9bdd63e1f8018c',
    messagingSenderId: '448618094949',
    projectId: 'thorpj-henderm-csse480',
    authDomain: 'thorpj-henderm-csse480.firebaseapp.com',
    storageBucket: 'thorpj-henderm-csse480.appspot.com',
    measurementId: 'G-CZPL9MKKEV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtPeMOXfK23QsiTYbBOcyr2EvrW5RoPqI',
    appId: '1:448618094949:android:496bc0f25d02124af8018c',
    messagingSenderId: '448618094949',
    projectId: 'thorpj-henderm-csse480',
    storageBucket: 'thorpj-henderm-csse480.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVrc3i4ch2mSJgE45LMYoDOwg4XHxoxMI',
    appId: '1:448618094949:ios:0cd533dd30e7b861f8018c',
    messagingSenderId: '448618094949',
    projectId: 'thorpj-henderm-csse480',
    storageBucket: 'thorpj-henderm-csse480.appspot.com',
    iosBundleId: 'com.example.useCaseManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVrc3i4ch2mSJgE45LMYoDOwg4XHxoxMI',
    appId: '1:448618094949:ios:d2ae904d91cddf75f8018c',
    messagingSenderId: '448618094949',
    projectId: 'thorpj-henderm-csse480',
    storageBucket: 'thorpj-henderm-csse480.appspot.com',
    iosBundleId: 'com.example.useCaseManager.RunnerTests',
  );
}