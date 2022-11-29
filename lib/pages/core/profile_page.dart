import 'package:dropnote/models/user.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';

class ProfilePage extends StatelessWidget {
  final DNUser? user;
  const ProfilePage({
    super.key,
    this.user,
  });

  void signOut() {
    print("sign out clicked");
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AvatarListItem(
                  imageURL:
                      "https://avatars.dicebear.com/api/bottts/dicebears.svg",
                  label: "",
                  avatarHeight: 100,
                  avatarWidth: 100,
                ),
                SizedBox(width: 45),
                Column(
                  children: const [
                    Text(
                      "15",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Saves",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  children: const [
                    Text(
                      "7",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Uploads",
                      style: TextStyle(fontSize: 20),
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
                    children: const [
                      Text("Nash Mahmoud",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35)),
                      Text(
                        "Louisiana State University",
                        style: TextStyle(fontSize: 20),
                      ),
                      // Text("nmah12@lsu.edu"),
                    ],
                  )
                ],
              )),
          Bar(),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [SubtitleBar(title: "Files:")],
            ),
          )
        ],
      ),
    );
  }
}
