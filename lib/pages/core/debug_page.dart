// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropnote/theme.dart';
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

class User {
  // Make these private + remove named parameters

  final String name;
  final String email;
  final String school;
  final int? totalSaves;
  final List<String>? uploadedFiles;
  final List<String>? savedFiles;

  User({
    required this.name,
    required this.email,
    required this.school,
    this.totalSaves,
    this.uploadedFiles,
    this.savedFiles,
  });

  String _getUrl() {
    String toUrl(x) => "https://avatars.dicebear.com/api/bottts/$x.svg";
    String encodedName = Uri.encodeComponent(name.toLowerCase());
    return toUrl(encodedName);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "school": school,
        "profilePicture": _getUrl(),
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
    FirebaseFirestore db = FirebaseFirestore.instance;

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

class ViewAllUsers extends StatelessWidget {
  const ViewAllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewAllUsers"),
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
