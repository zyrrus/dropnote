import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/schools.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/pages/core/core_page.dart';
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
  "Linear Algebra",
  "Graphics",
  "Real Analysis",
  "OS",
  "Networking",
  "Software Engineering",
];

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final searchController = TextEditingController();
  List<Widget> getTags() => tmpTagNames.map((e) => Tag(e)).toList();
  List<DNUser> people = [];
  List<DNFile> files = [];

  bool showQuery = false;
  List<DNUser> queryPeople = [];
  List<DNFile> queryFiles = [];

  List<Widget> toPeopleList(List<DNUser> people) => people
      .map((e) => AvatarListItem(label: e.name, imageURL: e.profilePicture))
      .toList();

  Future<List<Widget>> toFileList(List<DNFile> files) async {
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

  Future<List<Widget>> getPeople() async {
    List<DNUser> people = await UserAPI.getAllUsers();
    if (mounted) setState(() => this.people = people);
    return toPeopleList(people);
  }

  Future<List<Widget>> getFiles() async {
    var files = await FileAPI.getAllFiles();
    if (mounted) setState(() => this.files = files);
    return toFileList(files);
  }

  List<Widget> getSchools() => SchoolAPI.getSchools()
      .map((e) => AvatarListItem(label: e.name, imageURL: e.image))
      .toList();

  void onSubmitSearch(String query, BuildContext context) {
    query = query.toLowerCase();

    if (mounted) setState(() => showQuery = query.isNotEmpty);
    if (query.isEmpty) return;

    bool queryFile(DNFile f) {
      bool nameMatch = f.fileName.toLowerCase().contains(query);
      bool tagMatch = false;
      // if (f.tags is List<String>) {
      //   for (var tag in f.tags!) {
      //     if (tag.contains(query)) {
      //       tagMatch = true;
      //       break;
      //     }
      //   }
      // }
      return nameMatch || tagMatch;
    }

    bool queryPerson(DNUser u) {
      bool nameMatch = u.name.toLowerCase().contains(query);
      return nameMatch;
    }

    List<DNFile> queriedFiles = files.where(queryFile).toList();
    List<DNUser> queriedPeople = people.where(queryPerson).toList();

    if (mounted) {
      setState(() {
        queryFiles = queriedFiles;
        queryPeople = queriedPeople;
      });
    }
  }

  List<Widget> landingPage(BuildContext context) => [
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
      ];

  List<Widget> resultsPage(files, people) => [
        SubtitleBar(
            title: "People",
            onIconPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscoverPeoplePage(people: people),
                ),
              );
            }),
        HorizontalList(children: toPeopleList(people)),
        const Bar(),
        SubtitleBar(
            title: "Files",
            onIconPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscoverDocsPage(docs: files),
                ),
              );
            }),
        AsyncHorizontalList(source: () => toFileList(files)),
      ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleBar(title: "Discover"),
          SearchBar(
              controller: searchController,
              onSubmit: (query) => onSubmitSearch(query, context)),
          const Bar(),
          ...((showQuery)
              ? resultsPage(queryFiles, queryPeople)
              : landingPage(context)),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
