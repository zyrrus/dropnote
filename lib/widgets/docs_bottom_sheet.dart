import 'package:dropnote/models/file.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/horizontal_list.dart';
import 'package:dropnote/widgets/tag.dart';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class DocsBottomSheet extends StatefulWidget {
  final DNFile fileData;
  const DocsBottomSheet({super.key, required this.fileData});

  @override
  State<DocsBottomSheet> createState() => _DocsBottomSheetState();
}

class _DocsBottomSheetState extends State<DocsBottomSheet> {
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

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  DropNote.pagePadding, 40, DropNote.pagePadding, 0),
              child: Row(
                children: [
                  Text(
                    widget.fileData.fileName,
                    style: DropNote.textStyles.h1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Bar(),
            BottomTabSettingListItem(
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
              child: BottomTabSettingListItem(
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
            BottomTabSettingListItem(title: "Edit Tags"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
            const Bar(),
            Padding(
              padding: EdgeInsets.only(right: DropNote.pagePadding),
              child: Row(
                children: [
                  const BottomTabSettingListItem(
                    title: "Preview pages",
                    subtitle: "Pages available before saving",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delete",
                    style: DropNote.textStyles.main(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                  Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomTabSettingListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;

  const BottomTabSettingListItem({
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
