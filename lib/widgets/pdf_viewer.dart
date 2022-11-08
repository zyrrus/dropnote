import 'dart:typed_data';

import 'package:alh_pdf_view/lib.dart';
import 'package:dropnote/api/docs.dart';
import 'package:dropnote/pages/file_viewer_page.dart';
import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:thumbnailer/thumbnailer.dart';

class PDFViewer extends StatelessWidget {
  final String filename;

  const PDFViewer({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: DocApi.getFileFromDatabase(filename),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PDFLarge(pdfData: snapshot.data);
        }
        return const Center(
          child: SizedBox.square(
            dimension: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class PDFLarge extends StatefulWidget {
  final Uint8List? pdfData;

  const PDFLarge({Key? key, this.pdfData}) : super(key: key);

  @override
  _PDFLargeState createState() => _PDFLargeState();
}

class _PDFLargeState extends State<PDFLarge> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AlhPdfView(
      bytes: widget.pdfData,
      swipeHorizontal: false,
      fitEachPage: true,
      autoSpacing: true,
      // defaultZoomFactor: 0.9,
      fitPolicy: FitPolicy.width,
      backgroundColor: DropNote.colors.clear,
    );
  }
}

class PDFSmall extends StatefulWidget {
  final String filename;

  const PDFSmall({super.key, required this.filename});

  @override
  State<PDFSmall> createState() => _PDFSmallState();
}

class _PDFSmallState extends State<PDFSmall> {
  Uint8List? pdfData;

  Future<Uint8List> getPdfData() async {
    Uint8List data = await DocApi.getFileFromDatabase(widget.filename);
    setState(() => pdfData = data);
    return data;
  }

  void showFileViewer(BuildContext context) {
    if (pdfData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FileViewPage(
            filename: widget.filename,
            pdfData: pdfData!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: GestureDetector(
        onTap: () => showFileViewer(context),
        child: Thumbnail(
          mimeType: 'application/pdf',
          widgetSize: MediaQuery.of(context).size.width,
          dataResolver: getPdfData,
        ),
      ),
    );
  }
}
