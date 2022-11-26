import 'package:dropnote/api/users.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/fire_constants.dart';
import 'package:dropnote/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

class FileAPI {
  static Future<DNUser> _currentOrUserID({String? userID}) async {
    // Get current user if there's no userID
    DNUser user;

    if (userID is String) {
      var userData = await db.collection(Collections.users).doc(userID).get();
      user = DNUser.fromJson(userData, null);
    } else {
      user = await UserAPI.getCurrent();
    }

    return user;
  }

  static Future<List<DNFile>> getAllFiles({bool download = false}) async {
    var rawData = await db.collection(Collections.files).get();
    var files = rawData.docs.map((e) => DNFile.fromJson(e, null));
    return files.toList();
  }

  static Future<List<DNFile>> getUserFiles({String? userID}) async {
    DNUser user = await _currentOrUserID(userID: userID);

    List<DNFile> fileData = [];
    if (user.uploadedFiles is List<String>) {
      fileData = await FileAPI.getFilesFromList(user.uploadedFiles!);
    }

    return fileData;
  }

  static Future<List<DNFile>> getSavedFiles({String? userID}) async {
    DNUser user = await _currentOrUserID(userID: userID);

    List<DNFile> fileData = [];
    if (user.savedFiles is List<String>) {
      fileData = await FileAPI.getFilesFromList(user.uploadedFiles!);
    }

    return fileData;
  }

  static Future<List<DNFile>> getFilesFromList(List<String> fileIdList) async {
    var rawData = await db
        .collection(Collections.files)
        .where("fileID", whereIn: fileIdList)
        .get();
    var files = rawData.docs.map((e) => DNFile.fromJson(e, null));
    return files.toList();
  }
}
