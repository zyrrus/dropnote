import 'dart:ffi';

import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/schools.dart';
import 'package:dropnote/api/user.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:flutter/material.dart';

// Static Values Here
const tmpTagNames = [
  "Eman",
  "Dr. Nash",
  "Zeke",
  "Mr. Han",
  "OtisIV",
  "Kameron",
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

final List<User> _selectedUsers = [];
final List<User> _users = [
  User(
      'Manuel Steuber',
      '@elliana',
      'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
      false,
      2125),
  User(
      'Kayley Dwyer',
      '@kayley',
      'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
      false,
      561),
  User(
      'Kathleen Mcdonough',
      '@kathleen',
      'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
      false,
      54500),
  User(
      'Kathleen Dyer',
      '@kathleen',
      'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
      false,
      7442),
  User(
      'Mikayla Marquez',
      '@mikayla',
      'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
      false,
      73000.0),
  User(
      'Todd Goyette',
      '@mikayla',
      'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
      false,
      57.0),
];

// One Stop shop for all of our API methods
class ApiMethod {
  // Write classes and after importing the file type:
  // ApiMethod.{class name}

  static List<Tag> getTags() {
    return tmpTagNames.map((e) => Tag(e)).toList();
  }

  static List<AvatarListItem> getPeople() {
    return tmpPeopleNames
        .map((e) => AvatarListItem(
              label: e,
              imageURL:
                  "https://avatars.dicebear.com/api/bottts/${Uri.encodeComponent(e)}.svg",
            ))
        .toList();
  }

  static List<User> getUsers() {
    return _users;
  }

  Future<List<Widget>> getFiles() async {
    var files = await FileAPI.getAllFiles();
    return files
        .map((e) => SizedBox(
              width: 300.0,
              child: FileListItem(
                filename: e.fileName,
                numSaves: e.saveCount,
                ownerName: e.ownerName,
              ),
            ))
        .toList();
  }

  static List<AvatarListItem> getSchools() {
    return SchoolAPI.getSchools()
        .map((e) => AvatarListItem(label: e.name, imageURL: e.image))
        .toList();
  }
}
