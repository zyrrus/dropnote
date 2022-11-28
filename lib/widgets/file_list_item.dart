import 'dart:typed_data';

import 'package:dropnote/api/file_data.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/pages/view_file_page.dart';
import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:thumbnailer/thumbnailer.dart';

enum FileInfoStyle {
  uploading,
  uploaded,
  saved,
}

class FileListItem extends StatelessWidget {
  final FileInfoStyle fileStyle;
  final DNFile fileData;
  final void Function()? onIconPressed;

  const FileListItem({
    super.key,
    required this.fileStyle,
    required this.fileData,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileThumbnail(fileID: fileData.fileID, fileName: fileData.fileName),
        FileDetails(
          fileStyle: fileStyle,
          fileName: fileData.fileName,
          numSaves: fileData.saveCount ?? 0,
          ownerName: fileData.ownerName,
          onIconPressed: onIconPressed,
        ),
      ],
    );
  }
}

//

class FileThumbnail extends StatefulWidget {
  final String fileID;
  final String fileName;

  const FileThumbnail(
      {super.key, required this.fileID, required this.fileName});

  @override
  State<FileThumbnail> createState() => _FileThumbnailState();
}

class _FileThumbnailState extends State<FileThumbnail> {
  Uint8List? fileData;

  Future<Uint8List> getFileData() async {
    Uint8List data = await FileDataAPI.loadFromDatabase(widget.fileID);
    setState(() => fileData = data);
    return data;
  }

  void showFileViewer(BuildContext context) {
    if (fileData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewFilePage(
            name: widget.fileName,
            data: fileData!,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getFileData();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = (x * 9.0) / 16.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: (fileData is Uint8List)
          ? GestureDetector(
              onTap: () => showFileViewer(context),
              child: Container(
                height: y,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Thumbnail(
                  decoration: WidgetDecoration(
                    backgroundColor: DropNote.colors.lightGrey.withOpacity(0.5),
                  ),
                  mimeType: 'application/pdf',
                  widgetSize: x,
                  dataResolver: getFileData,
                ),
              ),
            )
          : const Placeholder(
              child: AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: SizedBox.expand(),
              ),
            ),
    );
  }
}

//

class FileDetails extends StatelessWidget {
  final FileInfoStyle fileStyle;
  final String fileName;
  final int? numSaves;
  final String? ownerName;
  final void Function()? onIconPressed;

  const FileDetails({
    super.key,
    required this.fileStyle,
    required this.fileName,
    this.numSaves,
    this.ownerName,
    this.onIconPressed,
  });

  Widget getFileName() => Text(
        fileName,
        style: DropNote.textStyles.main(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget getIcon(IconData icon) => IconButton(
        padding: const EdgeInsets.only(bottom: 3.0),
        constraints: const BoxConstraints(),
        onPressed: onIconPressed,
        icon: Icon(
          icon,
          color: DropNote.colors.foreground,
          size: 22.0,
        ),
      );

  Widget getText(String text) => Text(
        text,
        style: DropNote.textStyles.main(
          fontSize: 16.0,
          color: DropNote.colors.darkGrey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    switch (fileStyle) {
      // === On Upload Page ====================================================
      case FileInfoStyle.uploading:
        return getFileName();
      // === On Documents > Uploaded Tab =======================================
      case FileInfoStyle.uploaded:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getFileName(), getIcon(Icons.more_vert)],
            ),
            getText("$numSaves saves"),
          ],
        );
      // === On Documents > Saved Tab ==========================================
      case FileInfoStyle.saved:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getFileName(), getIcon(Icons.save_alt_rounded)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getText(ownerName!), getText("$numSaves saves")],
            ),
          ],
        );
    }
  }
}
