import 'package:dropnote/api/files.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/docs_bottom_sheet.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:flutter/material.dart';

class DocsUploadTab extends StatelessWidget {
  const DocsUploadTab({super.key});

  Future<List<Widget>> getFiles(BuildContext context) async {
    var data = await FileAPI.getMyFiles("1");
    return data
        .map((e) => Padding(
              padding: EdgeInsets.only(bottom: DropNote.pagePadding),
              child: FileListItem(
                filename: e.fileName,
                numSaves: e.saveCount,
                onIconPressed: () => showModalBottomSheet(
                  enableDrag: true,
                  isScrollControlled: true,
                  backgroundColor: DropNote.colors.background,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      topRight: Radius.circular(60.0),
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
      child: FutureBuilder<List<Widget>>(
          future: getFiles(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
