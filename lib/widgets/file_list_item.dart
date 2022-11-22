import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class FileListItem extends StatelessWidget {
  final String filename;
  final int numSaves;
  final void Function()? onIconPressed;
  final String? ownerName; // Leave empty if it is 'my file'

  const FileListItem({
    super.key,
    required this.filename,
    required this.numSaves,
    this.onIconPressed,
    this.ownerName,
  });

  Widget getDetailsElement(String text) => Text(
        text,
        style: DropNote.textStyles.main(
          fontSize: 16.0,
          color: DropNote.colors.darkGrey,
        ),
      );

  List<Widget> getDetailsRow() {
    var saves = getDetailsElement("$numSaves saves");
    return (ownerName is String && ownerName!.isNotEmpty)
        ? [getDetailsElement(ownerName!), saves]
        : [saves];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: File Thumbnail
        const Placeholder(
          child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: SizedBox.expand(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              filename,
              style: DropNote.textStyles.main(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: onIconPressed,
              icon: Icon(
                  (ownerName is String && ownerName!.isNotEmpty)
                      ? Icons.save_alt
                      : Icons.more_vert,
                  color: DropNote.colors.foreground,
                  size: 22.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getDetailsRow(),
        ),
      ],
    );
  }
}
