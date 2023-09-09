import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseOptionsClass {
  static FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY'].toString(),
    projectId: dotenv.env['FIREBASE_PROJECT_ID'].toString(),
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'].toString(),
    appId: dotenv.env['FIREBASE_APP_ID'].toString(),
  );
}
