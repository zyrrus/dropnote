import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class RequestListItem extends StatelessWidget {
  final String who;
  final String what;

  const RequestListItem({super.key, required this.who, required this.what});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DropNote.pagePadding,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.close_sharp,
            color: DropNote.colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "$who has requested $what",
                style: DropNote.textStyles.main(fontSize: 18.0),
              ),
            ),
          ),
          const DNIconButton(icon: Icons.check),
        ],
      ),
    );
  }
}

class NotificationListItem extends StatelessWidget {
  final String text;

  const NotificationListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DropNote.pagePadding,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.close_sharp,
            color: DropNote.colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                text,
                style: DropNote.textStyles.main(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
