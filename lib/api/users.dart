import 'package:dropnote/models/fire_constants.dart';
import 'package:dropnote/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

class UserAPI {
  static Future<DNUser> getCurrent() async {
    var curUser = auth.currentUser;
    if (curUser is User) {
      return await getUserByID(curUser.uid);
    }
    throw Exception("No current user");
  }

  static Future<DNUser> getUserByID(String userID) async {
    var rawData = await db.collection(Collections.users).doc(userID).get();
    return DNUser.fromJson(rawData, null);
  }

  static Future<List<DNUser>> getAllUsers() async {
    var rawData = await db.collection(Collections.users).get();
    var users = rawData.docs.map((e) => DNUser.fromJson(e, null));
    return users.toList();
  }

  static Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (ex) {
      print("Could not sign in");
    }
  }

  static Future<void> signup(
      String email, String password, String name, String school) async {
    UserCredential uc;
    try {
      // Create user in Auth
      UserCredential uc = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DNUser user = DNUser(
        name: name,
        userID: uc.user!.uid,
        school: school,
        email: email,
      );

      // Create user in Firestore
      await db
          .collection(Collections.users)
          .doc(user.userID)
          .set(user.toJson());
    } catch (ex) {
      print("Could not sign up");
    }
  }
}
