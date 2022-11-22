import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class FileListItem extends StatelessWidget {
  final String filename;
  final int numSaves;
  final String? ownerName; // Leave empty if it is 'my file'

  const FileListItem({
    super.key,
    required this.filename,
    required this.numSaves,
    this.ownerName,
  });

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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              filename,
              style: DropNote.textStyles.main(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save_alt, size: 22.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (ownerName is String)
              Text(
                ownerName!,
                style: DropNote.textStyles.main(
                  fontSize: 16.0,
                  color: DropNote.colors.darkGrey,
                ),
              ),
            Text(
              "$numSaves saves",
              style: DropNote.textStyles.main(
                fontSize: 16.0,
                color: DropNote.colors.darkGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
