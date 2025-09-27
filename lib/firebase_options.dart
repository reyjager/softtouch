import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyCFUJN3_gzqHVriddFsOms78A7PUJZQkDc',
    appId: '1:130531998295:web:9d44db9ce97605636c4112',
    messagingSenderId: '130531998295',
    projectId: 'softtouch-ca86c',
    authDomain: 'softtouch-ca86c.firebaseapp.com',
    storageBucket: 'softtouch-ca86c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFUJN3_gzqHVriddFsOms78A7PUJZQkDc',
    appId: '1:130531998295:android:9d44db9ce97605636c4112',
    messagingSenderId: '130531998295',
    projectId: 'softtouch-ca86c',
    storageBucket: 'softtouch-ca86c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjPsh98g1WZyG3oaWWIe2-TMb64Z94Iq0',
    appId: '1:130531998295:ios:7dd8ae316248df186c4112',
    messagingSenderId: '130531998295',
    projectId: 'softtouch-ca86c',
    storageBucket: 'softtouch-ca86c.firebasestorage.app',
    iosBundleId: 'com.example.softtouch',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFUJN3_gzqHVriddFsOms78A7PUJZQkDc',
    appId: '1:130531998295:macos:9d44db9ce97605636c4112',
    messagingSenderId: '130531998295',
    projectId: 'softtouch-ca86c',
    storageBucket: 'softtouch-ca86c.firebasestorage.app',
    iosBundleId: 'com.example.softtouch',
  );
}