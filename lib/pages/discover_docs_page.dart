import 'package:dropnote/api/users.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class DiscoverDocsPage extends StatefulWidget {
  final List<DNFile> docs;

  const DiscoverDocsPage({Key? key, required this.docs}) : super(key: key);

  @override
  State<DiscoverDocsPage> createState() => _DiscoverDocsPageState();
}

class _DiscoverDocsPageState extends State<DiscoverDocsPage> {
  Future<List<Widget>> getFiles() async {
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

    return widget.docs
        .map((e) => Padding(
              padding: EdgeInsets.only(bottom: DropNote.pagePadding),
              child: FileListItem(
                fileStyle: getStyle(e.fileID),
                fileData: e,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleBar(title: "Documents", showBackButton: true),
            const Bar(),
            FutureBuilder<List<Widget>>(
              future: getFiles(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
                    child: Column(children: snapshot.data!),
                  );
                }
                return const Center(
                  child: SizedBox.square(
                    dimension: 100.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
