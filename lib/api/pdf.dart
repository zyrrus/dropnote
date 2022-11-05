import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class PDFApi {
  static Future<String> getAssetFromUrl(String url) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      final filename = url.substring(url.lastIndexOf("/") + 1);

      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();

      var bytes = await consolidateHttpClientResponseBytes(response);
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);

      return file.path;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }

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
}
