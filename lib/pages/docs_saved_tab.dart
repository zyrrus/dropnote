import 'package:dropnote/api/files.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/docs_bottom_sheet.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:flutter/material.dart';

class DocsSavedTab extends StatelessWidget {
  const DocsSavedTab({super.key});

  Future<List<Widget>> getFiles(BuildContext context) async {
    try {
      var data = await FileAPI.getSavedFiles();
      return data
          .map((e) => Padding(
                padding: EdgeInsets.only(bottom: DropNote.pagePadding),
                child: FileListItem(
                  fileStyle: FileInfoStyle.deleteableDoc,
                  fileData: e,
                ),
              ))
          .toList();
    } catch (ex) {
      return [
        Padding(
          padding: EdgeInsets.only(bottom: DropNote.pagePadding),
          child: const Text("Could not get files"),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<Widget>>(
          future: getFiles(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: snapshot.data!);
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
