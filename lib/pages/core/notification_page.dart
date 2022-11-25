import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/notification_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
// Author : Otis Jackson IV
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleBar(title: "Notifications"),
        const Bar(),
        const SubtitleBar(title: "Requests"),
        RequestListItem(who: "First Lastname", what: "Filename.txt"),
        RequestListItem(who: "First Lastname", what: "Filename.txt"),
        RequestListItem(who: "First Lastname", what: "Filename.txt"),
        const Bar(),
        const SubtitleBar(title: "Saves"),
        NotificationListItem(text: "First Lastname saved Filename.txt"),
        NotificationListItem(text: "First Lastname saved Filename.txt"),
        NotificationListItem(text: "First Lastname saved Filename.txt"),
      ],
    );
  }
}
