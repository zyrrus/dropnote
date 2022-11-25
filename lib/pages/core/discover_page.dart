import 'dart:math';

import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/schools.dart';
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

const tmpPeopleNames = [
  "Josephine Pfeffer PhD",
  "Carolyn Wolff",
  "Miss Laurence Von",
  "Dr. Allison Russel",
  "Sam Kuhic",
  "Rosie McLaughlin",
  "Manuel Steuber",
  "Mitchell Runte",
  "Debra Hodkiewicz",
];

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  List<Widget> getTags() => tmpTagNames.map((e) => Tag(e)).toList();

  List<Widget> getPeople() => tmpPeopleNames
      .map((e) => AvatarListItem(
            label: e,
            imageURL:
                "https://avatars.dicebear.com/api/bottts/${Uri.encodeComponent(e)}.svg",
          ))
      .toList();

  Future<List<Widget>> getFiles() async {
    var files = await FileAPI.getAllFiles();
    return files
        .map((e) => SizedBox(
              width: 300.0,
              child: FileListItem(
                fileStyle: FileInfoStyle.saved,
                fileName: e.fileName,
                numSaves: e.saveCount,
                ownerName: e.ownerName,
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
          HorizontalList(children: getPeople()),
          const Bar(),
          SubtitleBar(title: "Popular Files", onIconPressed: () {}),
          FutureBuilder<List<Widget>>(
              future: getFiles(),
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
              }),
          const Bar(),
          const SubtitleBar(title: "Active Schools"),
          HorizontalList(children: getSchools()),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
