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
    apiKey: 'AIzaSyChICKosCRLlhcKweyLAcD0ZvAnEtbi-n8',
    appId: '1:395261574070:web:35255e69c8f113c1bd9f17',
    messagingSenderId: '395261574070',
    projectId: 'chat-app-6e847',
    authDomain: 'chat-app-6e847.firebaseapp.com',
    storageBucket: 'chat-app-6e847.appspot.com',
    measurementId: 'G-4QC5EJ2QGX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNhvyA0Arjv-YDmJFpndHc4Fo9e0QiO38',
    appId: '1:395261574070:android:52c24bcc980f88f0bd9f17',
    messagingSenderId: '395261574070',
    projectId: 'chat-app-6e847',
    storageBucket: 'chat-app-6e847.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM9r2MRxj-zsJCn2U8DUBzH6icsG78dak',
    appId: '1:395261574070:ios:afe40ef8720a5bb9bd9f17',
    messagingSenderId: '395261574070',
    projectId: 'chat-app-6e847',
    storageBucket: 'chat-app-6e847.appspot.com',
    iosClientId: '395261574070-apj0vouvfjdo1g2s1tp892sn0drjo5p6.apps.googleusercontent.com',
    iosBundleId: 'com.example.myChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM9r2MRxj-zsJCn2U8DUBzH6icsG78dak',
    appId: '1:395261574070:ios:afe40ef8720a5bb9bd9f17',
    messagingSenderId: '395261574070',
    projectId: 'chat-app-6e847',
    storageBucket: 'chat-app-6e847.appspot.com',
    iosClientId: '395261574070-apj0vouvfjdo1g2s1tp892sn0drjo5p6.apps.googleusercontent.com',
    iosBundleId: 'com.example.myChatApp',
  );
}
