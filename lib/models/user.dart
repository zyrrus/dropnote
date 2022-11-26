import 'package:cloud_firestore/cloud_firestore.dart';

class DNUser {
  final String name;
  final String email;
  final String school;
  int? totalSaves;
  List<String>? uploadedFiles;
  List<String>? savedFiles;

  String get profilePicture {
    String encodedName = Uri.encodeComponent(name.toLowerCase());
    return "https://avatars.dicebear.com/api/bottts/$encodedName.svg";
  }

  DNUser({
    required this.name,
    required this.email,
    required this.school,
    this.totalSaves,
    this.uploadedFiles,
    this.savedFiles,
  });

  factory DNUser.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DNUser(
      name: data?['name'],
      email: data?['email'],
      school: data?['school'],
      totalSaves: data?['totalSaves'],
      uploadedFiles: data?['uploadedFiles'] is Iterable
          ? List<String>.from(data?['uploadedFiles'])
          : null,
      savedFiles: data?['savedFiles'] is Iterable
          ? List<String>.from(data?['savedFiles'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "school": school,
        "profilePicture": profilePicture,
        "totalSaves": totalSaves ?? 0,
        "uploadedFiles": uploadedFiles ?? [],
        "savedFiles": savedFiles ?? [],
      };
}
