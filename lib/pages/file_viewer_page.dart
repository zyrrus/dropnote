import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:dropnote/widgets/top_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class FileViewPage extends StatelessWidget {
  final String filename;
  final Uint8List pdfData;

  const FileViewPage({
    super.key,
    required this.filename,
    required this.pdfData,
  });

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: Column(
        children: [
          TopBar(
            title: "File Viewer",
            showBackButton: true,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: DropNote.colors.disabled,
                  borderRadius: BorderRadius.circular(8.0)),
              child: PDFLarge(pdfData: pdfData),
            ),
          ),
          SizedBox(
            height: 16.0,
          )
        ],
      ),
    );
  }
}
