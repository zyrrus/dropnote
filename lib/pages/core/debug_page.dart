// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
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
      ),
    );
  }
}

// === Sub Features ============================================================

class Collections {
  static String users = "users";
  static String files = "files";
}

FirebaseFirestore db = FirebaseFirestore.instance;

class User {
  // Make these private + remove named parameters

  final String name;
  final String email;
  final String school;
  final int? totalSaves;
  final List<DocumentReference>? uploadedFiles;
  final List<DocumentReference>? savedFiles;

  String get profilePicture {
    String encodedName = Uri.encodeComponent(name.toLowerCase());
    return "https://avatars.dicebear.com/api/bottts/$encodedName.svg";
  }

  const User({
    required this.name,
    required this.email,
    required this.school,
    this.totalSaves,
    this.uploadedFiles,
    this.savedFiles,
  });

  factory User.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      name: data?['name'],
      email: data?['email'],
      school: data?['school'],
      totalSaves: data?['totalSaves'],
      uploadedFiles: data?['uploadedFiles'] is Iterable
          ? List<DocumentReference>.from(data?['uploadedFiles'])
          : null,
      savedFiles: data?['savedFiles'] is Iterable
          ? List<DocumentReference>.from(data?['savedFiles'])
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
    User user = User(
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

//

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({super.key});

  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  List<User> allUsers = [];
  String? error;

  void getAllUsers() {
    db.collection(Collections.users).get().then(
          (res) => setState(() {
            allUsers = res.docs.map((e) => User.fromJson(e, null)).toList();
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

//

class ViewQueriedUsers extends StatefulWidget {
  const ViewQueriedUsers({super.key});

  @override
  State<ViewQueriedUsers> createState() => _ViewQueriedUsersState();
}

class _ViewQueriedUsersState extends State<ViewQueriedUsers> {
  List<User> queriedUsers = [];
  String? error;
  final TextEditingController queryController = TextEditingController();

  Future<List<User>> getAllUsers() async {
    List<User> allUsers = [];
    await db.collection(Collections.users).get().then(
          (res) => allUsers.addAll(res.docs.map((e) => User.fromJson(e, null))),
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

class UploadFile extends StatelessWidget {
  const UploadFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "UploadFile"),
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
