import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class DocApi {
  static Future<Uint8List> getFileFromDatabase(String filename) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final docRef = storageRef.child(filename);
      final Uint8List? data = await docRef.getData();

      if (data == null) {
        throw Exception("Could not load file");
      }

      return data;
    } catch (_) {
      throw Exception("Could not load file");
    }
  }

  // TODO: uploadFileToDatabase()
}
