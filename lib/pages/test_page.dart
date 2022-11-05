import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(TestPage());

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Test Page",
            style: DropNote.textStyles.pageHeader(),
          ),
          Expanded(
            // constraints: BoxConstraints(
            //     maxHeight: MediaQuery.of(context).size.height),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: DropNote.colors.disabled,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const PDFViewer(url: "dropteam-product-strategy.pdf"),
              // child: const PDFViewer(url: "dropnote.pdf"),
            ),
          ),
        ],
      ),
    );
  }
}
