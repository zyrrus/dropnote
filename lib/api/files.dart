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
      fileData = await FileAPI.getFilesFromList(user.savedFiles!);
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

  static Future<void> saveFile(DNFile file) async {
    // Update file
    file.saveCount = (file.saveCount is int) ? file.saveCount! + 1 : 0;
    await updateFile(file);

    // Update Owner
    var them = await UserAPI.getUserByID(file.ownerID);
    them.totalSaves = (them.totalSaves is int) ? them.totalSaves! + 1 : 1;
    await UserAPI.updateUser(them);

    // Update Me
    var me = await UserAPI.getCurrent();
    if (me.savedFiles is List<String>) {
      me.savedFiles!.add(file.fileID);
    } else {
      me.savedFiles = [file.fileID];
    }
    await UserAPI.updateUser(me);
  }

  static Future<void> unsaveFile(DNFile file) async {
    // Update file
    file.saveCount = (file.saveCount is int) ? file.saveCount! - 1 : 0;
    await updateFile(file);

    // Update Owner
    var them = await UserAPI.getUserByID(file.ownerID);
    them.totalSaves = (them.totalSaves is int) ? them.totalSaves! - 1 : 0;
    await UserAPI.updateUser(them);

    // Update Me
    var me = await UserAPI.getCurrent();
    if (me.savedFiles is List<String>) {
      me.savedFiles!.remove(file.fileID);
      await UserAPI.updateUser(me);
    }
  }

  static Future<void> updateFile(DNFile newFile) async {
    var id = newFile.fileID;

    if (newFile.saveCount is int && newFile.saveCount! < 0) {
      newFile.saveCount = 0;
    }

    await db.collection(Collections.files).doc(id).update(newFile.toJson());
  }

  static Future<DNFile> uploadFile(String fileName, DNUser owner,
      int previewPageCount, List<String> tags) async {
    var fileRef = db.collection(Collections.files).doc();

    DNFile file = DNFile(
      fileName: fileName,
      fileID: fileRef.id,
      ownerName: owner.name,
      ownerID: owner.userID,
      previewPageCount: previewPageCount,
      tags: tags,
    );

    // add doc to files collection
    await fileRef.set(file.toJson());

    return file;
  }
}
