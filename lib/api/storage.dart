import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

var storage = FirebaseStorage.instance;

class StorageAPI {
  static Future<Uint8List?> downloadFile(String fileID) async {
    try {
      final storageRef = storage.ref();
      final docRef = storageRef.child(fileID);
      final Uint8List? data = await docRef.getData();
      return data;
    } catch (_) {
      print("Could not load file");
    }
    return null;
  }

  static Future<void> uploadFile(PlatformFile data, String fileID) async {
    File localFile = File(data.path!);
    await storage.ref().child(fileID).putFile(
          localFile,
          SettableMetadata(contentType: 'application/pdf'),
        );
  }
}
