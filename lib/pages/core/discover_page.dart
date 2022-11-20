import 'dart:math';

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

const tmpFiles = [
  "synergized.pdf",
  "total.pdf",
  "salad_super.pdf",
  "grass_roots.pdf",
];

const tmpSchools = [
  // [name, url]
  [
    "Louisiana State University",
    "https://www.klfy.com/wp-content/uploads/sites/9/2019/07/lsu_logo2_400x400.jpg"
  ],
  [
    "University of Louisiana Lafayette",
    "https://pbs.twimg.com/profile_images/817127494788804608/SmY_ctJX_400x400.jpg"
  ],
  [
    "Tulane University",
    "https://pbs.twimg.com/profile_images/1116476139558572032/XJyCCQd4_400x400.jpg"
  ],
  [
    "McNeese State University",
    "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/McNeese_State_Athletics_logo.svg/1200px-McNeese_State_Athletics_logo.svg.png"
  ],
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

  List<Widget> getFiles() => tmpFiles
      .map((e) => FileListItem(
            filename: e,
            numSaves: Random(123).nextInt(99999),
            ownerName: "First Lastname",
          ))
      .toList();

  List<Widget> getSchools() => tmpSchools
      .map((e) => AvatarListItem(imageURL: e[1], label: e[0]))
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
          HorizontalList(children: getFiles()),
          const Bar(),
          const SubtitleBar(title: "Active Schools"),
          HorizontalList(children: getSchools()),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
