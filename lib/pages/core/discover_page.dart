import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/schools.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/pages/discover_docs_page.dart';
import 'package:dropnote/pages/discover_people_page.dart';
import 'package:dropnote/api/users.dart';
import 'package:dropnote/widgets/avatar_list_item.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/search_bar.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

const tmpTagNames = [
  "numqua!!",
  "maiores",
  "nostrum",
  "lorem",
  "ipsum",
];

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Widget> getTags() => tmpTagNames.map((e) => Tag(e)).toList();
  List<DNUser> people = [];
  List<DNFile> files = [];

  Future<List<Widget>> getPeople() async {
    List<DNUser> people = await UserAPI.getAllUsers();
    setState(() => this.people = people);
    return people
        .map((e) => AvatarListItem(label: e.name, imageURL: e.profilePicture))
        .toList();
  }

  Future<List<Widget>> getFiles() async {
    var files = await FileAPI.getAllFiles();
    var me = await UserAPI.getCurrent();

    FileInfoStyle getStyle(String otherID) {
      bool isMine = me.uploadedFiles?.contains(otherID) ?? false;
      bool isSaved = me.savedFiles?.contains(otherID) ?? false;

      if (isMine) {
        return FileInfoStyle.uploadedDoc;
      } else if (isSaved) {
        return FileInfoStyle.deleteableDoc;
      } else {
        return FileInfoStyle.saveableDoc;
      }
    }

    setState(() => this.files = files);
    return files
        .map((e) => SizedBox(
              width: 300.0,
              child: FileListItem(
                height: 300.0 * 9.0 / 16.0,
                fileStyle: getStyle(e.fileID),
                fileData: e,
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
          SearchBar(
            controller: TextEditingController(),
          ),
          const Bar(),
          const SubtitleBar(title: "Tags you may like"),
          HorizontalList(spacing: 10.0, children: getTags()),
          const Bar(),
          SubtitleBar(
              title: "People from your school",
              onIconPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscoverPeoplePage(people: people),
                  ),
                );
              }),
          AsyncHorizontalList(source: getPeople),
          const Bar(),
          SubtitleBar(
              title: "Popular Files",
              onIconPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscoverDocsPage(docs: files),
                  ),
                );
              }),
          AsyncHorizontalList(source: getFiles),
          const Bar(),
          const SubtitleBar(title: "Active Schools"),
          HorizontalList(children: getSchools()),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}

class AsyncHorizontalList extends StatelessWidget {
  final Future<List<Widget>> Function() source;

  const AsyncHorizontalList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: source(),
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
        });
  }
}
