import 'package:dropnote/theme.dart';
import 'dart:math';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          Icons.close_sharp,
          color: Colors.grey[400],
        ),
        SizedBox(
          width: 8.0,
        ),
        Container(
          width: 290,
          child: Text(
            'First Lastname has requested Filename.txt',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(99.0),
          ),
          child: Icon(
            Icons.check,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
