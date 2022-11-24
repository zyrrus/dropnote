import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  String filename = '';

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleBar(
          title: "Upload File",
          showBackButton: true,
        ),
        const Bar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: InkWell(
            onTap: () => UploadFile(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select File",
                      textAlign: TextAlign.left,
                      style: DropNote.textStyles.h1(),
                    ),
                    Text(
                      filename,
                      textAlign: TextAlign.left,
                      style: DropNote.textStyles.s1(),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.drive_file_move_rtl_outlined,
                  color: DropNote.colors.foreground,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
        const Bar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: InkWell(
            onTap: () => null,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Preview",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.h2(),
                        ),
                        Text(
                          "View file how others will see it",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.s1(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: DropNote.colors.foreground,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Bar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: InkWell(
            onTap: () => null,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Request-only",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.h2(),
                        ),
                        Text(
                          "Manually approve who can save",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.s1(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.lock_outlined,
                      color: DropNote.colors.foreground,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Bar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: InkWell(
            onTap: () => null,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Preview pages",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.h2(),
                        ),
                        Text(
                          "Number of pages visible before saving",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.s1(),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.looks_one_outlined,
                      color: DropNote.colors.foreground,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Bar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
          child: InkWell(
            onTap: () => null,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Tags",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.h2(),
                        ),
                        Text(
                          "Help other find your files",
                          textAlign: TextAlign.left,
                          style: DropNote.textStyles.s1(),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void UploadFile() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );

    if (results != null) {
      final path = results!.files.single.path!;

      filename = results.files.single.name;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }
}
