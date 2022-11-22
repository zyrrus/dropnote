import 'package:dropnote/api/files.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/docs_bottom_sheet.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:flutter/material.dart';

class DocsSavedTab extends StatelessWidget {
  const DocsSavedTab({super.key});

  Future<List<Widget>> getFiles(BuildContext context) async {
    var data = await FileAPI.getSavedFiles("1");
    return data
        .map((e) => Padding(
              padding: EdgeInsets.only(bottom: DropNote.pagePadding),
              child: FileListItem(
                filename: e.fileName,
                numSaves: e.saveCount,
                ownerName: e.ownerName,
                icon: Icons.more_vert,
                onIconPressed: () => showModalBottomSheet(
                  enableDrag: true,
                  isScrollControlled: true,
                  backgroundColor: DropNote.colors.background,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0),
                    ),
                  ),
                  context: context,
                  builder: (context) => DocsBottomSheet(),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<Object>(
          future: getFiles(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: snapshot.data as List<Widget>);
            }
            return const Center(
              child: SizedBox.square(
                dimension: 100.0,
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
