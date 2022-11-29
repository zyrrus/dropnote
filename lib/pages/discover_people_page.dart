import 'package:dropnote/models/user.dart';
import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/people_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class DiscoverPeoplePage extends StatelessWidget {
  final List<DNUser> people;

  const DiscoverPeoplePage({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleBar(title: "People", showBackButton: true),
            const Bar(),
            ...people
                .map((e) => PeopleListItem(
                      user: e,
                      isExpanded: true,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
