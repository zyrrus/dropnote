import 'dart:async';
import 'dart:typed_data';

import 'package:dropnote/api/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewer extends StatelessWidget {
  final String url;

  const PDFViewer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: PDFApi.getFileFromDatabase(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _PDF(pdfData: snapshot.data);
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

class _PDF extends StatefulWidget {
  final Uint8List? pdfData;

  _PDF({Key? key, this.pdfData}) : super(key: key);

  __PDFState createState() => __PDFState();
}

class __PDFState extends State<_PDF> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return PDFView(
      fitEachPage: true,
      enableSwipe: true,
      pdfData: widget.pdfData,
      // enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: true,
      pageSnap: true,
      defaultPage: currentPage!,
      fitPolicy: FitPolicy.WIDTH,
      preventLinkNavigation: false,
      onRender: (_pages) {
        setState(() {
          pages = _pages;
          isReady = true;
        });
      },
      onError: (error) {
        setState(() {
          errorMessage = error.toString();
        });
      },
      onPageError: (page, error) {
        setState(() {
          errorMessage = '$page: ${error.toString()}';
        });
      },
      onViewCreated: (PDFViewController pdfViewController) {
        _controller.complete(pdfViewController);
      },
      onLinkHandler: (String? uri) {},
      onPageChanged: (int? page, int? total) {
        setState(() {
          currentPage = page;
        });
      },
    );
  }
}
