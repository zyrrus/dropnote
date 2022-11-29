import 'package:dropnote/api/files.dart';
import 'package:dropnote/api/storage.dart';
import 'package:dropnote/api/users.dart';
import 'package:dropnote/models/file.dart';
import 'package:dropnote/models/user.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:dropnote/widgets/text_button.dart';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  FocusNode myFocusNode = FocusNode();

  // File params
  PlatformFile? platformFile;
  bool isRequestOnly = true;
  TextEditingController pageCountController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  List<String> tagNames = [];

  void toggleRequestOnly() => setState(() => isRequestOnly = !isRequestOnly);

  List<Widget> getTags() => tagNames.map((e) => Tag(e)).toList();

  void addTag(String tag) {
    if (tagController.text.isNotEmpty) {
      tagNames.add(tagController.text);
      tagController.clear();
      myFocusNode.requestFocus();
    }
    setState(() {});
  }

  void getFile(PlatformFile f) => setState(() => platformFile = f);

  Future<void> onUploadPressed(BuildContext context) async {
    if (platformFile is! PlatformFile) return;

    try {
      // Get data
      DNUser user = await UserAPI.getCurrent();
      DNFile file = await FileAPI.uploadFile(
        platformFile!.name,
        user,
        int.tryParse(pageCountController.text.trim()) ?? -1,
        tagNames,
      );

      // Update user > uploaded files
      if (user.uploadedFiles is List<String>) {
        user.uploadedFiles!.add(file.fileID);
      } else {
        user.uploadedFiles = [file.fileID];
      }
      await UserAPI.updateUser(user);

      // Add to storage
      await StorageAPI.uploadFile(platformFile!, file.fileID);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploaded ${file.fileName}")),
      );
    } catch (ex) {
      print("Could not upload file");
    }
    if (!myFocusNode.hasPrimaryFocus) {
      myFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200.0,
        child: DNTextButton(
          onTap: () => onUploadPressed(context),
          text: "Upload File",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleBar(
              title: "Upload File",
              showBackButton: true,
            ),
            const Bar(),
            SelectFile(onFileSelect: getFile),
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
              onTap: toggleRequestOnly,
              child: UploadSettingListItem(
                title: "Request-only",
                subtitle: "Manually approve who can save",
                icon: Icon(
                  (isRequestOnly
                      ? Icons.lock_outlined
                      : Icons.lock_open_outlined),
                  color: DropNote.colors.foreground,
                  size: 32,
                ),
              ),
            ),
            const Bar(),
            Padding(
              padding: EdgeInsets.only(right: DropNote.pagePadding),
              child: Row(
                children: [
                  const UploadSettingListItem(
                    title: "Preview pages",
                    subtitle: "Number of pages visible before saving",
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: TextFormField(
                      controller: pageCountController,
                      cursorColor: DropNote.colors.primary,
                      textAlign: TextAlign.center,
                      style:
                          DropNote.textStyles.main(fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: DropNote.colors.primary),
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
            SizedBox(height: 200.0),
          ],
        ),
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
  final void Function(PlatformFile) onFileSelect;

  const SelectFile({super.key, required this.onFileSelect});

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  String filename = '';

  void pickFile() async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (results is FilePickerResult) {
      PlatformFile f = results.files.first;
      widget.onFileSelect(f);
      setState(() => filename = f.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: Row(
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
        ),
        if (filename.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: UploadSettingListItem(
              title: "Currently selected",
              subtitle: filename,
            ),
          ),
      ],
    );
  }
}

class FixedCenterDockedFabLocation extends StandardFabLocation
    with FabCenterOffsetX, FabDockedOffsetY {
  const FixedCenterDockedFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.fixedCenterDocked';

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double bottomMinInset = scaffoldGeometry.minInsets.bottom;
    if (bottomMinInset > 0) {
      // Hide if there's a keyboard
      return 0;
    }
    return super.getOffsetY(scaffoldGeometry, adjustment);
  }
}
