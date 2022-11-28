import 'dart:math';

import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/schools.dart';
import 'package:dropnote/api/users.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/search_bar.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

const tmpTagNames = [
  "numquam",
  "maiores",
  "nostrum",
  "lorem",
  "ipsum",
];

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  List<Widget> getTags() => tmpTagNames.map((e) => Tag(e)).toList();

  Future<List<Widget>> getPeople() async {
    List<DNUser> users = await UserAPI.getAllUsers();
    return users
        .map((e) => AvatarListItem(label: e.name, imageURL: e.profilePicture))
        .toList();
  }

  Future<List<Widget>> getFiles() async {
    var files = await FileAPI.getAllFiles();
    return files
        .map((e) => SizedBox(
              width: 300.0,
              child: FileListItem(
                fileStyle: FileInfoStyle.saved,
                fileData: e,
                onIconPressed: () {},
              ),
            ))
        .toList();
  }

  List<Widget> getSchools() => SchoolAPI.getSchools()
      .map((e) => AvatarListItem(label: e.name, imageURL: e.image))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleBar(title: "Discover"),
          SearchBar(controller: TextEditingController()),
          const Bar(),
          const SubtitleBar(title: "Tags you may like"),
          HorizontalList(spacing: 10.0, children: getTags()),
          const Bar(),
          SubtitleBar(title: "People from your school", onIconPressed: () {}),
          AsyncHorizontalList(source: getPeople),
          const Bar(),
          SubtitleBar(title: "Popular Files", onIconPressed: () {}),
          AsyncHorizontalList(source: getFiles),
          const Bar(),
          const SubtitleBar(title: "Active Schools"),
          HorizontalList(children: getSchools()),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}

class AsyncHorizontalList extends StatelessWidget {
  final Future<List<Widget>> Function() source;

  const AsyncHorizontalList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: source(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HorizontalList(children: snapshot.data!);
          }
          return const Center(
            child: SizedBox.square(
              dimension: 100.0,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
