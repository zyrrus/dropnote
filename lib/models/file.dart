import 'package:cloud_firestore/cloud_firestore.dart';

class DNFile {
  final String fileName;
  final String ownerID;
  final String ownerName;
  int? previewPageCount;
  int? saveCount;
  List<String>? tags;

  DNFile({
    required this.fileName,
    required this.ownerID,
    required this.ownerName,
    this.previewPageCount,
    this.saveCount,
    this.tags,
  });

  factory DNFile.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DNFile(
      fileName: data?['fileName'],
      ownerID: data?['ownerID'],
      ownerName: data?['ownerName'],
      previewPageCount: data?['previewPageCount'],
      saveCount: data?['saveCount'],
      tags: data?['tags'] is Iterable
          ? List<String>.from(data?['uploadedFiles'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "ownerID": ownerID,
        "ownerName": ownerName,
        "previewPageCount": previewPageCount ?? -1,
        "saveCount": saveCount ?? 0,
        "tags": tags ?? [],
      };
}
