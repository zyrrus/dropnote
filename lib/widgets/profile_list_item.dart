import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem(
      {super.key, required this.professorName, required this.schoolName});

  final String professorName;
  final String schoolName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.account_circle_outlined,
          size: 70,
          color: DropNote.colors.secondary,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                professorName,
                style: DropNote.textStyles
                    .body(color: DropNote.colors.foreground, fontSize: 20),
              ),
              Text(
                schoolName,
                style: DropNote.textStyles
                    .body(color: DropNote.colors.disabled, fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }
}
