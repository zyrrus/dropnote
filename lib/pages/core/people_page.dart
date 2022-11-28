import 'package:dropnote/models/user.dart';
import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/widgets/people_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  final List<DNUser> people;

  const PeoplePage({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleBar(title: "People", showBackButton: true),
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
