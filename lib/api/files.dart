import 'dart:convert';
import 'package:flutter/services.dart';

class FileDetails {
  final String url;
  final String fileName;
  final String fileID;
  final String ownerName;
  final String ownerID;
  final int saveCount;
  final List<dynamic> tags;
  final bool isRequestOnly;
  final int previewPageCount;

  FileDetails({
    required this.url,
    required this.fileName,
    required this.fileID,
    required this.ownerName,
    required this.ownerID,
    required this.saveCount,
    required this.isRequestOnly,
    required this.tags,
    required this.previewPageCount,
  });

  factory FileDetails.fromJSON(String fileID, dynamic json) {
    return FileDetails(
      // get url by combining ownername + filename
      url: json['ownerName'] + json['fileName'],
      fileName: json['fileName'],
      fileID: fileID,
      ownerName: json['ownerName'],
      ownerID: json['ownerID'],
      saveCount: json['saveCount'],
      isRequestOnly: json['isRequestOnly'],
      tags: json['tags'],
      previewPageCount: json['previewPageCount'],
    );
  }
}

class FileAPI {
  static Future<List<FileDetails>> _getAllFiles() async {
    // Read json data
    var file = await rootBundle.loadString('assets/fake_data/files.json');
    var json = jsonDecode(file) as Map;

    // Convert JSON to FileDetails
    List<FileDetails> files = [];
    json.forEach((k, v) => files.add(FileDetails.fromJSON(k, v)));

    return files;
  }

  static Future<List<FileDetails>> getMyFiles(String userID) async {
    List<FileDetails> files = await _getAllFiles();
    return files.where((e) => e.ownerID == userID).toList();
  }

  static Future<List<FileDetails>> getSavedFiles(String userID) async {
    // TODO: This method is not implemented correctly
    List<FileDetails> files = await _getAllFiles();
    return files.where((e) => e.ownerID != userID).toList();
  }
}
