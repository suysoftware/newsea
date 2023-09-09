import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:newsea/core/models/ns_user.dart';
import 'package:newsea/feature/screens/home/controller/home_controller.dart';

class FirebaseAuthService {
  // ignore: body_might_complete_normally_nullable
  static Future<User?> loginFirebase() async {
    try {
      await FirebaseAuth.instance.signInAnonymously().then((kullanici) {
        //_isSigningIn = true;
      });
      User? user = FirebaseAuth.instance.currentUser;

      return user;
    } catch (e) {
      // ignore: avoid_print
    }
  }

  // ignore: body_might_complete_normally_nullable
  static Future<NsUser?> loggedCheck() async {
    print("aga");
    User? user = FirebaseAuth.instance.currentUser;

    final HomeController homeController = Get.find();
    // Platform messages may fail, so we use a try/catch PlatformException.

    if (user != null) {
      print("icerisi");
      var nsUser = await getUser(user.uid);
      homeController.updateUser(nsUser);
    } else {
      await loginFirebase().then((user) async {
        var nsUser = await getUser(user!.uid);
        homeController.updateUser(nsUser);
      });
    }
  }

  static Future<void> logoutFirebase() async {
    try {
      if (!kIsWeb) {
        //await firebaseAuth.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<dynamic> secureTokenGetter() async {
    User? user = FirebaseAuth.instance.currentUser;
    var token = await user!.getIdToken();
    return token;
  }

  static Future<NsUser> getUser(String userUid) async {
    // ignore: prefer_typing_uninitialized_variables
    var nsUser;
    final nsUserRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .withConverter(fromFirestore: (snapshot, _) => NsUser.fromJson(snapshot.data()!), toFirestore: (nsuser, _) => nsuser.toJson());
    nsUser = await nsUserRef.get();

    return nsUser.data();
  }
}
