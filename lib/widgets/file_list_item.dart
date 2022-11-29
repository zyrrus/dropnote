import 'dart:typed_data';

import 'package:dropnote/api/storage.dart';
import 'package:dropnote/api/files.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/pages/view_file_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/docs_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:thumbnailer/thumbnailer.dart';

enum FileInfoStyle {
  uploadedDoc,
  saveableDoc,
  deleteableDoc,
}

class FileListItem extends StatefulWidget {
  final FileInfoStyle fileStyle;
  final DNFile fileData;
  final double? height;

  const FileListItem({
    super.key,
    required this.fileStyle,
    required this.fileData,
    this.height,
  });

  @override
  State<FileListItem> createState() => _FileListItemState();
}

class _FileListItemState extends State<FileListItem> {
  late FileInfoStyle _fileStyle;

  @override
  void initState() {
    super.initState();
    _fileStyle = widget.fileStyle;
  }

  // Possible onClick methods

  void Function() pickOnClick(BuildContext context) {
    switch (widget.fileStyle) {
      case FileInfoStyle.uploadedDoc:
        return () => showBottomSheet(context);
      case FileInfoStyle.deleteableDoc:
        return unsaveFile;
      case FileInfoStyle.saveableDoc:
        return saveFile;
    }
  }

  void showBottomSheet(BuildContext context) => showModalBottomSheet(
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
        builder: (context) => DocsBottomSheet(fileData: widget.fileData),
      );

  Future<void> saveFile() async {
    await FileAPI.saveFile(widget.fileData);
    setState(() => _fileStyle = FileInfoStyle.deleteableDoc);
  }

  Future<void> unsaveFile() async {
    await FileAPI.unsaveFile(widget.fileData);
    setState(() => _fileStyle = FileInfoStyle.saveableDoc);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileThumbnail(
          fileID: widget.fileData.fileID,
          fileName: widget.fileData.fileName,
          height: widget.height,
        ),
        FileDetails(
          fileStyle: _fileStyle,
          fileName: widget.fileData.fileName,
          numSaves: widget.fileData.saveCount ?? 0,
          ownerName: widget.fileData.ownerName,
          onPressed: pickOnClick(context),
        ),
      ],
    );
  }
}

//

class FileThumbnail extends StatefulWidget {
  final String fileID;
  final String fileName;
  final double? height;

  const FileThumbnail({
    super.key,
    required this.fileID,
    required this.fileName,
    this.height,
  });

  @override
  State<FileThumbnail> createState() => _FileThumbnailState();
}

class _FileThumbnailState extends State<FileThumbnail> {
  Uint8List? fileData;

  Future<void> getFileData() async {
    Uint8List? data = await StorageAPI.downloadFile(widget.fileID);
    setState(() => fileData = data);
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
    double y = widget.height ?? (x * 9.0) / 16.0;

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
                  dataResolver: () async => fileData!,
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
  final void Function()? onPressed;

  const FileDetails({
    super.key,
    required this.fileStyle,
    required this.fileName,
    this.onPressed,
    this.numSaves,
    this.ownerName,
  });

  // Sub-widgets

  Widget getFileName() => Text(
        fileName,
        style: DropNote.textStyles.main(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget getIcon(IconData icon) => IconButton(
        padding: const EdgeInsets.only(bottom: 3.0),
        constraints: const BoxConstraints(),
        onPressed: onPressed,
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
      case FileInfoStyle.uploadedDoc:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: getFileName()),
                getIcon(Icons.more_vert)
              ],
            ),
            getText("$numSaves saves"),
          ],
        );
      case FileInfoStyle.saveableDoc:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: getFileName()),
                getIcon(Icons.save_alt_rounded)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getText(ownerName!), getText("$numSaves saves")],
            ),
          ],
        );
      default: // FileInfoStyle.deleteableDoc
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: getFileName()),
                getIcon(Icons.delete_outlined)
              ],
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
