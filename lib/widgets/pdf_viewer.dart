import 'dart:typed_data';

import 'package:alh_pdf_view/lib.dart';
import 'package:dropnote/api/docs.dart';
import 'package:flutter/material.dart';
import 'package:thumbnailer/thumbnailer.dart';

class PDFViewer extends StatelessWidget {
  final String url;

  const PDFViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: DocApi.getFileFromDatabase(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _PDFLarge(pdfData: snapshot.data);
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

class _PDFLarge extends StatefulWidget {
  final Uint8List? pdfData;

  const _PDFLarge({Key? key, this.pdfData}) : super(key: key);

  @override
  __PDFLargeState createState() => __PDFLargeState();
}

class __PDFLargeState extends State<_PDFLarge> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AlhPdfView(
      bytes: widget.pdfData,
      swipeHorizontal: false,
      fitEachPage: false,
      autoSpacing: false,
      defaultZoomFactor: 2.0,
      backgroundColor: Colors.red,
    );
  }
}

class PDFSmall extends StatelessWidget {
  final String url;

  const PDFSmall({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Thumbnail(
        mimeType: 'application/pdf',
        widgetSize: MediaQuery.of(context).size.width,
        dataResolver: () => DocApi.getFileFromDatabase(url),
      ),
    );
  }
}
