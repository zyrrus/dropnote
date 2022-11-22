import 'package:dropnote/theme.dart';
import 'dart:math';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/file_list_item.dart';
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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Notifications',
            style: DropNote.textStyles.main(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Requests',
                  style: DropNote.textStyles.main(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Wrap(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Row(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Row(
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
                        size: 25,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'Saves',
                  style: DropNote.textStyles.main(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.close_sharp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      child: Text(
                        'First Lastname saved Filename.txt',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.close_sharp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      child: Text(
                        'First Lastname saved Filename.txt',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.close_sharp,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      child: Text(
                        'First Lastname saved Filename.txt',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
