import 'package:dropnote/models/file.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  String filename = '';

  void uploadFile() async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (results != null) {
      final path = results.files.single.path!;

      filename = results.files.single.name;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleBar(
            title: "Upload File",
            showBackButton: true,
          ),
          const Bar(),
          const SelectFile(),
          const Bar(),
          UploadSettingListItem(
            title: "Preview",
            subtitle: "View file how others will see it",
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: DropNote.colors.foreground,
              size: 32,
            ),
          ),
          const Bar(),
          UploadSettingListItem(
            title: "Request-only",
            subtitle: "Manually approve who can save",
            icon: Icon(
              Icons.lock_outlined,
              color: DropNote.colors.foreground,
              size: 32,
            ),
          ),
          const Bar(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, DropNote.pagePadding, 0),
            child: Row(
              children: [
                const UploadSettingListItem(
                  title: "Preview pages",
                  subtitle: "Number of pages visible before saving",
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style:
                        DropNote.textStyles.main(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Bar(),
          const UploadSettingListItem(
            title: "Add Tags",
            subtitle: "Help others find your files",
          ),
          // TODO: add list of tags + text input box
        ],
      ),
    );
  }
}

class UploadSettingListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;

  const UploadSettingListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: DropNote.textStyles.h2()),
              Text(subtitle ?? "", style: DropNote.textStyles.s1()),
            ],
          ),
          if (icon is Widget) icon!,
        ],
      ),
    );
  }
}

class SelectFile extends StatefulWidget {
  const SelectFile({super.key});

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  // TODO: temporary
  bool hasFileSelected = false;
  DNFile? file;

  void pickFile() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Select a file", style: DropNote.textStyles.h1()),
              DNIconButton(
                icon: Icons.drive_file_move_outlined,
                isLarge: true,
                onTap: pickFile,
              ),
            ],
          ),
          if (file is DNFile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Currently selected", style: DropNote.textStyles.h2()),
                FileListItem(
                  fileStyle: FileInfoStyle.uploading,
                  fileData: file!,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
