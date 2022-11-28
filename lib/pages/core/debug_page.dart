// ignore_for_file: prefer__ructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/fire_constants.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtitleBar(title: "CurrentlySignedIn"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
                child: Text(auth.currentUser?.email ?? "No one is signed in"),
              ),
            ],
          ),
          Bar(),
          CreateNewUser(),
          Bar(),
          SignIn(),
          Bar(),
          ViewAllUsers(),
          Bar(),
          ViewQueriedUsers(),
          Bar(),
          UploadFile(),
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

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

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
  final TextEditingController passwordController = TextEditingController();

  Future<void> createUser() async {
    String email = emailController.text.toLowerCase().trim();
    String password = passwordController.text.trim();

    UserCredential uc;
    try {
      uc = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (ex) {
      uc = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } finally {
      await auth.signOut();
      await auth.signInWithEmailAndPassword(
        email: "nash@lsu.edu",
        password: "123456",
      );
    }

    DNUser user = DNUser(
      name: nameController.text.trim(),
      userID: uc.user!.uid,
      school: schoolController.text.trim(),
      email: email,
    );

    db.collection(Collections.users).doc(user.userID).set(user.toJson());

    nameController.clear();
    emailController.clear();
    schoolController.clear();
    passwordController.clear();
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
        // School
        TextField(
          decoration: InputDecoration(hintText: "School", labelText: "School"),
          controller: schoolController,
        ),
        // Email
        TextField(
          decoration: InputDecoration(hintText: "Email", labelText: "Email"),
          controller: emailController,
        ),
        // Password
        TextField(
          obscureText: true,
          decoration:
              InputDecoration(hintText: "Password", labelText: "Password"),
          controller: passwordController,
        ),
        ElevatedButton(onPressed: createUser, child: Text("Create User")),
      ],
    );
  }
}

// Done

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    String email = emailController.text.toLowerCase().trim();
    String password = passwordController.text.trim();

    auth.signInWithEmailAndPassword(email: email, password: password);

    emailController.clear();
    passwordController.clear();
  }

  void signOut() => auth.signOut();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "SignIn"),
        // Email
        TextField(
          decoration: InputDecoration(hintText: "Email", labelText: "Email"),
          controller: emailController,
        ),
        // Password
        TextField(
          obscureText: true,
          decoration:
              InputDecoration(hintText: "Password", labelText: "Password"),
          controller: passwordController,
        ),
        ElevatedButton(onPressed: signIn, child: Text("Sign In")),
        const Bar(),
        SubtitleBar(title: "SignOut"),
        ElevatedButton(onPressed: signOut, child: Text("Sign Out")),
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

// Done

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
      fileID: fileRef.id,
      ownerName: user.name,
      ownerID: me.uid,
    );

    // add doc to files collection
    fileRef.set(file.toJson());

    // add to storage
    String storageName = fileRef.id;
    File localFile = File(fileData.path!);
    storage.ref().child(storageName).putFile(
          localFile,
          SettableMetadata(contentType: 'application/pdf'),
        );

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
        // TODO: add settings fields (request only...)
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

// Done

class ViewAllFiles extends StatefulWidget {
  const ViewAllFiles({super.key});

  @override
  State<ViewAllFiles> createState() => _ViewAllFilesState();
}

class _ViewAllFilesState extends State<ViewAllFiles> {
  List<DNFile> allFiles = [];
  String? error;

  void getAllFiles() {
    db.collection(Collections.files).get().then(
          (res) => setState(() {
            allFiles = res.docs.map((e) => DNFile.fromJson(e, null)).toList();
          }),
          onError: (e) => setState(() => error = "Error completing: $e"),
        );
  }

  bool isMyFile(DNFile f) {
    var me = auth.currentUser;
    if (me is User) {
      var myID = auth.currentUser!.uid;
      return f.ownerID == myID;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubtitleBar(title: "ViewAllFiles"),
        ...allFiles
            .map((e) => FileListItem(
                fileStyle: (isMyFile(e))
                    ? FileInfoStyle.uploadedDoc
                    : FileInfoStyle.deleteableDoc,
                fileData: e))
            .toList(),
        ElevatedButton(onPressed: getAllFiles, child: Text("View All Files"))
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
