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
    apiKey: 'AIzaSyDLsKp0NpeGw7AWi5No5uo7G3dEObKFldQ',
    appId: '1:86273195823:web:5f6e7aaf1e817528246bda',
    messagingSenderId: '86273195823',
    projectId: 'mfulife-demo',
    authDomain: 'mfulife-demo.firebaseapp.com',
    storageBucket: 'mfulife-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWQ5JdEU2fp2T8aOOlQnMwckQfToiq9rc',
    appId: '1:86273195823:android:8fcc8fd15b37153f246bda',
    messagingSenderId: '86273195823',
    projectId: 'mfulife-demo',
    storageBucket: 'mfulife-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfij3MLh2J4fJgcJk2wKb0-Z_Lux-V3Bo',
    appId: '1:86273195823:ios:1cbb00edd2e29120246bda',
    messagingSenderId: '86273195823',
    projectId: 'mfulife-demo',
    storageBucket: 'mfulife-demo.appspot.com',
    iosBundleId: 'com.example.mfuLifeDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfij3MLh2J4fJgcJk2wKb0-Z_Lux-V3Bo',
    appId: '1:86273195823:ios:1cbb00edd2e29120246bda',
    messagingSenderId: '86273195823',
    projectId: 'mfulife-demo',
    storageBucket: 'mfulife-demo.appspot.com',
    iosBundleId: 'com.example.mfuLifeDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLsKp0NpeGw7AWi5No5uo7G3dEObKFldQ',
    appId: '1:86273195823:web:97d68994ccce5d2f246bda',
    messagingSenderId: '86273195823',
    projectId: 'mfulife-demo',
    authDomain: 'mfulife-demo.firebaseapp.com',
    storageBucket: 'mfulife-demo.appspot.com',
  );
}
