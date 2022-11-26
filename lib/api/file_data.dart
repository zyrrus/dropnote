import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FileDataAPI {
  static Future<Uint8List> loadFromDatabase(String fileID) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final docRef = storageRef.child(fileID);
      final Uint8List? data = await docRef.getData();

      if (data == null) {
        throw Exception("Could not load file");
      }

      return data;
    } catch (_) {
      throw Exception("Could not load file");
    }
  }
}
