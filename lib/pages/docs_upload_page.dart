import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:dropnote/widgets/setting_list_item.dart';
import 'package:dropnote/widgets/text_input.dart';
import 'package:dropnote/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class DocsUploadPage extends StatelessWidget {
  const DocsUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    var border;
    return CoreTemplate(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar(title: "Upload", showBackButton: true),
            const PDFSmall(filename: "dropteam-product-strategy.pdf"),
            SettingListItem(
              label: "Number of preview pages",
              setting: Text("1", style: DropNote.textStyles.setting()),
            ),
            const SettingListItem(
              label: "Make request-only",
              setting: Icon(Icons.check_box_outline_blank),
            ),
            const SettingListItem(
              label: "Add Tags",
              isSectionHeader: true,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                "Lorem",
                "ipsum",
                "dolor",
                "sit",
                "amet",
                "consectetur",
                "adipiscing",
                "elit",
              ].map((e) => _Tag("$e")).toList(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 14.0),
              child: TextInput(
                label: "Tag",
                placeholder: "Add tags to this document",
              ),
            ),
            const SizedBox(height: 100.0)
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String tagname;

  const _Tag(this.tagname, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: DropNote.colors.disabled,
          width: 2.0,
        ),
      ),
      child: Text(
        tagname,
        style: DropNote.textStyles.body(
          color: DropNote.colors.foreground,
        ),
      ),
    );
  }
}
