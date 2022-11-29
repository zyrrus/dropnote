import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/users.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';

class ProfilePage extends StatefulWidget {
  final DNUser? user;
  const ProfilePage({
    super.key,
    this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<DNUser> _user;

  Future<void> signOut() async => await FirebaseAuth.instance.signOut();

  Future<List<Widget>> getFiles(DNUser user) async {
    var me = await UserAPI.getCurrent();

    FileInfoStyle getStyle(String otherID) {
      bool isMine = me.uploadedFiles?.contains(otherID) ?? false;
      bool isSaved = me.savedFiles?.contains(otherID) ?? false;

      if (isMine) {
        return FileInfoStyle.uploadedDoc;
      } else if (isSaved) {
        return FileInfoStyle.deleteableDoc;
      } else {
        return FileInfoStyle.saveableDoc;
      }
    }

    List<DNFile> files = (user.uploadedFiles is List<String>)
        ? await FileAPI.getFilesFromList(user.uploadedFiles!)
        : [];

    return files
        .map((e) => Padding(
              padding: EdgeInsets.only(bottom: DropNote.pagePadding),
              child: FileListItem(
                fileStyle: getStyle(e.fileID),
                fileData: e,
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    if (widget.user is DNUser) {
      _user = (() async => _user)();
    } else {
      _user = UserAPI.getCurrent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DNUser>(
        future: _user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          DNUser user = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                TitleBar(
                  title: "Profile",
                  suffixIcon: DNIconButton(
                    icon: Icons.logout_outlined,
                    onTap: signOut,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AvatarListItem(
                        imageURL: user.profilePicture,
                        label: "",
                        avatarHeight: 100,
                        avatarWidth: 100,
                      ),
                      const SizedBox(width: 45),
                      Column(
                        children: [
                          Text(
                            "${user.totalSaves}",
                            style: DropNote.textStyles.main(fontSize: 20),
                          ),
                          Text(
                            "Saves",
                            style: DropNote.textStyles.main(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            "${user.uploadedFiles?.length ?? 0}",
                            style: DropNote.textStyles.main(fontSize: 20),
                          ),
                          Text(
                            "Uploads",
                            style: DropNote.textStyles.main(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: DropNote.textStyles.main(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            Text(
                              user.school,
                              style: DropNote.textStyles.main(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    )),
                const Bar(),
                const SubtitleBar(title: "Files:"),
                FutureBuilder<List<Widget>>(
                  future: getFiles(user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: DropNote.pagePadding,
                        ),
                        child: Column(children: snapshot.data!),
                      );
                    }
                    return const Center(
                      child: SizedBox.square(
                        dimension: 100.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
