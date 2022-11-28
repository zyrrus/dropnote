import 'package:dropnote/main.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/file_list_item.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thumbnailer/thumbnailer.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  bool isRequest = true;
  TextEditingController tagController = TextEditingController();
  List<String> tagNames = [];
  FocusNode myFocusNode = FocusNode();

  void changeRequest() {
    isRequest = !isRequest;
    setState(() {});
  }

  List<Widget> getTags() => tagNames.map((e) => Tag(e)).toList();

  void addTag(String tag) {
    if (tagController.text.isNotEmpty) {
      tagNames.add(tagController.text);
      tagController.clear();
      myFocusNode.requestFocus();
    }
    setState(() {});
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
          // FileListItem(fileStyle: FileInfoStyle.uploading, fileData: )
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
          InkWell(
            onTap: changeRequest,
            child: UploadSettingListItem(
              title: "Request-only",
              subtitle: "Manually approve who can save",
              icon: Icon(
                (isRequest ? Icons.lock_outlined : Icons.lock_open_outlined),
                color: DropNote.colors.foreground,
                size: 32,
              ),
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
                    cursorColor: DropNote.colors.primary,
                    textAlign: TextAlign.center,
                    style:
                        DropNote.textStyles.main(fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: DropNote.colors.primary),
                      ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: HorizontalList(
              children: getTags(),
            ),
          ),
          TextInputField(
            textFocusNode: myFocusNode,
            onSubmit: addTag,
            controller: tagController,
            label: "Enter Tags",
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Align(
              child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(355, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: DropNote.colors.primary),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(DropNote.colors.primary)),
                onPressed: () => null,
                child: Text(
                  "Upload File",
                  style: DropNote.textStyles.p,
                ),
              ),
            ),
          )
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
              Text(title, style: DropNote.textStyles.h2),
              Text(subtitle ?? "", style: DropNote.textStyles.s1),
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
  String filename = '';

  void pickFile() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Select a file", style: DropNote.textStyles.h1),
              DNIconButton(
                icon: Icons.drive_file_move_outlined,
                isLarge: true,
                onTap: pickFile,
              ),
            ],
          ),
          if (filename != '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Currently selected", style: DropNote.textStyles.h2),
              ],
            ),
        ],
      ),
    );
  }
}
