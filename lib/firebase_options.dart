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
    apiKey: 'AIzaSyAAi3pahP44hnbc7MhoHJ4LceCBO61xDls',
    appId: '1:329135027324:web:cef973c166b679118d05f9',
    messagingSenderId: '329135027324',
    projectId: 'edspert-fp-learning-app',
    authDomain: 'edspert-fp-learning-app.firebaseapp.com',
    storageBucket: 'edspert-fp-learning-app.appspot.com',
    measurementId: 'G-DXBW4R14XX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnQS2EF4g-hlmvz_8DXzVJCisX6C5IxXw',
    appId: '1:329135027324:android:6ea18076d710cab68d05f9',
    messagingSenderId: '329135027324',
    projectId: 'edspert-fp-learning-app',
    storageBucket: 'edspert-fp-learning-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClVaIP_4UZPdqdgg-zMuR02fUANlndhao',
    appId: '1:329135027324:ios:e29b1491d000b5758d05f9',
    messagingSenderId: '329135027324',
    projectId: 'edspert-fp-learning-app',
    storageBucket: 'edspert-fp-learning-app.appspot.com',
    iosClientId: '329135027324-e5tts2vu8alkmdrfqkartfb6r68jnnqb.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterEdspertFpLearningApp',
  );
}
