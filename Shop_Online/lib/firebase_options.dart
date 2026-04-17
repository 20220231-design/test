import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'Nền tảng này chưa được hỗ trợ.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCGYHAlx8ha1yNJTXXLKwMobeVrCkyOfr4",
    authDomain: "shop-31c45.firebaseapp.com",
    projectId: "shop-31c45",
    storageBucket: "shop-31c45.appspot.com",
    messagingSenderId: "316955215079",
    appId: "1:316955215079:web:bf00e0085495985c2ece42",
    measurementId: "G-70XHEBHG2J",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCGYHAlx8ha1yNJTXXLKwMobeVrCkyOfr4",
    appId: "1:316955215079:web:bf00e0085495985c2ece42",
    messagingSenderId: "316955215079",
    projectId: "shop-31c45",
    storageBucket: "shop-31c45.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCGYHAlx8ha1yNJTXXLKwMobeVrCkyOfr4",
    appId: "1:316955215079:web:bf00e0085495985c2ece42",
    messagingSenderId: "316955215079",
    projectId: "shop-31c45",
    storageBucket: "shop-31c45.appspot.com",
    iosBundleId: "com.example.shoponline",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyCGYHAlx8ha1yNJTXXLKwMobeVrCkyOfr4",
    appId: "1:316955215079:web:bf00e0085495985c2ece42",
    messagingSenderId: "316955215079",
    projectId: "shop-31c45",
    storageBucket: "shop-31c45.appspot.com",
  );
}