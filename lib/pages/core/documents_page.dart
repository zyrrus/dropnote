import 'dart:math';

import 'package:dropnote/main.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void uploadButtonPressed(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => TestPage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox.square(
        dimension: 75.0,
        child: FloatingActionButton(
          onPressed: () => uploadButtonPressed(context),
          backgroundColor: DropNote.colors.primary,
          elevation: 0,
          highlightElevation: 0,
          child: Icon(Icons.add, size: 35.0, color: DropNote.colors.foreground),
        ),
      ),
      body: Column(
        children: [
          const TitleBar(title: "Documents"),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: DropNote.colors.lightGrey, width: 2.0),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
            child: TabBar(
              controller: _tabController,
              indicatorColor: DropNote.colors.primary,
              indicatorWeight: 3.0,
              labelColor: DropNote.colors.foreground,
              labelStyle: DropNote.textStyles.main(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: DropNote.textStyles.main(fontSize: 18.0),
              unselectedLabelColor: DropNote.colors.darkGrey,
              tabs: const [Tab(text: "Uploaded"), Tab(text: "Saved")],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [UploadedTab(), SavedTab()]
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.fromLTRB(
                        DropNote.pagePadding,
                        DropNote.pagePadding,
                        DropNote.pagePadding,
                        0.0,
                      ),
                      child: e,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const tmpFiles = [
  "synergized.pdf",
  "total.pdf",
  "salad_super.pdf",
  "grass_roots.pdf",
];

List<Widget> getFiles() => tmpFiles
    .map((e) => Padding(
          padding: EdgeInsets.only(bottom: DropNote.pagePadding),
          child: FileListItem(
            filename: e,
            numSaves: Random(123).nextInt(99999),
            ownerName: "First Lastname",
          ),
        ))
    .toList();

class UploadedTab extends StatelessWidget {
  const UploadedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: getFiles(),
      ),
    );
  }
}

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: getFiles(),
      ),
    );
  }
}
