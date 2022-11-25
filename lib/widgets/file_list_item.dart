import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

enum FileInfoStyle {
  uploading,
  uploaded,
  saved,
}

class FileListItem extends StatelessWidget {
  final String fileName;
  final FileInfoStyle fileStyle;
  final String? ownerName; // Leave empty if it is 'my file'
  final int? numSaves;
  final void Function()? onIconPressed;

  const FileListItem({
    super.key,
    required this.fileName,
    required this.fileStyle,
    this.ownerName,
    this.numSaves,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FileThumbnail(),
        FileDetails(
          fileStyle: fileStyle,
          fileName: fileName,
          numSaves: numSaves ?? 0,
          ownerName: ownerName ?? "",
          onIconPressed: onIconPressed,
        ),
      ],
    );
  }
}

class FileThumbnail extends StatelessWidget {
  const FileThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: File Thumbnail
    return const Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Placeholder(
        child: AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

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
