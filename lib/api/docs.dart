// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class DocApi {
//   static Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   static Future<Uint8List> get _localErrorFile async {
//     final path = await _localPath;
//     return File('$path/assets/error.pdf').readAsBytes();
//   }

//   static Future<Uint8List> getFileFromDatabase(String filename) async {
//     try {
//       final storageRef = FirebaseStorage.instance.ref();
//       final docRef = storageRef.child(filename);
//       final Uint8List? data = await docRef.getData();

//       if (data == null) {
//         throw Exception("Could not load file");
//       }

//       return data;
//     } catch (_) {
//       throw Exception("Could not load file");
//     }
//   }

//   // TODO: uploadFileToDatabase()
// }
