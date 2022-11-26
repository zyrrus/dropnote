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
}
