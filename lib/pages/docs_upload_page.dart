import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/pages/documents_page.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:dropnote/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class DocsUploadPage extends StatelessWidget {
  const DocsUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    var border;
    return CoreTemplate(
      child: Column(
        children: [
          TopBar(title: "Upload", showBackButton: true),
          //TODO: add component
          PDFSmall(filename: "dropteam-product-strategy.pdf"),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffc0c0c0),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Number of preview pages",
                  style: DropNote.textStyles.label(),
                ),
                Text(
                  "1",
                  style: DropNote.textStyles.label(),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffc0c0c0),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Request-only",
                  style: DropNote.textStyles.label(),
                ),
                Icon(Icons.check_box_outline_blank),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            child: Row(
              children: [
                Text(
                  "Add Tags",
                  style: DropNote.textStyles.label(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
