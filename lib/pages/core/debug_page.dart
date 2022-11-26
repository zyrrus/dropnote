// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBar(title: "Debug"),
          Bar(),
          CreateNewUser(),
          Bar(),
          ViewAllUsers(),
          Bar(),
          ViewQueriedUsers(),
          Bar(),
          UploadFile(),
          Bar(),
          SaveFile(),
          Bar(),
          UpdateMyFile(),
          Bar(),
          ViewAllFiles(),
          Bar(),
          ViewQueriedFiles(),
        ],
      ),
    );
  }
}

// === Sub Features ============================================================

class Collections {
  static String users = "users";
  static String files = "files";
}

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

class DNUser {
  // Make these private + remove named parameters

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

  factory DNFile.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
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

// Done

class CreateNewUser extends StatefulWidget {
  const CreateNewUser({super.key});

  @override
  State<CreateNewUser> createState() => _CreateNewUserState();
}

class _CreateNewUserState extends State<CreateNewUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void createUser() {
    DNUser user = DNUser(
      name: nameController.text.trim(),
      school: schoolController.text.trim(),
      email: emailController.text.toLowerCase().trim(),
    );

    db.collection(Collections.users).add(user.toJson());

    nameController.clear();
    emailController.clear();
    schoolController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "CreateNewUser"),
        // Name
        TextField(
          decoration: InputDecoration(hintText: "Name", labelText: "Name"),
          controller: nameController,
        ),
        // Email
        TextField(
          decoration: InputDecoration(hintText: "Email", labelText: "Email"),
          controller: emailController,
        ),
        // School
        TextField(
          decoration: InputDecoration(hintText: "School", labelText: "School"),
          controller: schoolController,
        ),
        ElevatedButton(onPressed: createUser, child: Text("Create User")),
      ],
    );
  }
}

// Done

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({super.key});

  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  List<DNUser> allUsers = [];
  String? error;

  void getAllUsers() {
    db.collection(Collections.users).get().then(
          (res) => setState(() {
            allUsers = res.docs.map((e) => DNUser.fromJson(e, null)).toList();
          }),
          onError: (e) => setState(() => error = "Error completing: $e"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewAllUsers"),
        ...allUsers
            .map((e) =>
                AvatarListItem(imageURL: e.profilePicture, label: e.name))
            .toList(),
        ElevatedButton(onPressed: getAllUsers, child: Text("View All Users"))
      ],
    );
  }
}

// Done

class ViewQueriedUsers extends StatefulWidget {
  const ViewQueriedUsers({super.key});

  @override
  State<ViewQueriedUsers> createState() => _ViewQueriedUsersState();
}

class _ViewQueriedUsersState extends State<ViewQueriedUsers> {
  List<DNUser> queriedUsers = [];
  String? error;
  final TextEditingController queryController = TextEditingController();

  Future<List<DNUser>> getAllUsers() async {
    List<DNUser> allUsers = [];
    await db.collection(Collections.users).get().then(
          (res) =>
              allUsers.addAll(res.docs.map((e) => DNUser.fromJson(e, null))),
          onError: (e) => setState(() => error = "Error completing: $e"),
        );

    return allUsers;
  }

  Future<void> queryUsers() async {
    var query = queryController.text.trim().toLowerCase();
    var allUsers = await getAllUsers();
    setState(() {
      queriedUsers = allUsers
          .where((user) =>
              user.name.toLowerCase().contains(query) ||
              user.school.toLowerCase().contains(query))
          .toList();
    });
    queryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewQueriedUsers"),
        ...queriedUsers
            .map((e) =>
                AvatarListItem(imageURL: e.profilePicture, label: e.name))
            .toList(),
        TextField(
          decoration: InputDecoration(hintText: "Query", labelText: "Query"),
          controller: queryController,
        ),
        ElevatedButton(onPressed: queryUsers, child: Text("Query Users"))
      ],
    );
  }
}

//

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  Future<PlatformFile?> pickFile() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    return results?.files.single;
  }

  Future<void> uploadFile() async {
    // pick file
    var fileData = await pickFile();
    if (fileData is! PlatformFile) return; // Indicate errors

    // Get Firebase references
    var me = auth.currentUser!;
    var userRef = db.collection(Collections.users).doc(me.uid);
    var fileRef = db.collection(Collections.files).doc();

    var userSnap = await userRef.get();
    if (!userSnap.exists) return;

    DNUser user = DNUser.fromJson(userSnap, null);

    DNFile file = DNFile(
      fileName: fileData.name,
      ownerName: user.name,
      ownerID: me.uid,
    );

    // add doc to files collection
    fileRef.set(file.toJson());

    // add to storage
    String storageName = fileRef.id;
    File localFile = File(fileData.path!);
    storage.ref().child(storageName).putFile(localFile);

    // update user > uploaded files
    if (user.uploadedFiles is List<String>) {
      user.uploadedFiles!.add(storageName);
    } else {
      user.uploadedFiles = [storageName];
    }

    userRef.update(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "UploadFile"),
        // TextField(
        //   decoration: InputDecoration(hintText: "Query", labelText: "Query"),
        //   controller: previewPagesController,
        // ),
        ElevatedButton(onPressed: uploadFile, child: Text("Upload File")),
      ],
    );
  }
}

//

class SaveFile extends StatelessWidget {
  const SaveFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "SaveFile"),
      ],
    );
  }
}

//

class UpdateMyFile extends StatelessWidget {
  const UpdateMyFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "UpdateMyFile"),
      ],
    );
  }
}

//

class ViewAllFiles extends StatelessWidget {
  const ViewAllFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewAllFiles"),
      ],
    );
  }
}

//

class ViewQueriedFiles extends StatelessWidget {
  const ViewQueriedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewQueriedFiles"),
      ],
    );
  }
}
