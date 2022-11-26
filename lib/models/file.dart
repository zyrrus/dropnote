import 'package:cloud_firestore/cloud_firestore.dart';

class DNFile {
  final String fileName;
  final String fileID;
  final String ownerName;
  final String ownerID;
  int? previewPageCount;
  int? saveCount;
  List<String>? tags;

  DNFile({
    required this.fileName,
    required this.fileID,
    required this.ownerName,
    required this.ownerID,
    this.previewPageCount,
    this.saveCount,
    this.tags,
  });

  factory DNFile.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return DNFile(
      fileName: data['fileName'],
      fileID: data['fileID'],
      ownerName: data['ownerName'],
      ownerID: data['ownerID'],
      previewPageCount: data['previewPageCount'],
      saveCount: data['saveCount'],
      tags: (data['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileID": fileID,
        "ownerName": ownerName,
        "ownerID": ownerID,
        "previewPageCount": previewPageCount ?? -1,
        "saveCount": saveCount ?? 0,
        "tags": tags ?? [],
      };
}
