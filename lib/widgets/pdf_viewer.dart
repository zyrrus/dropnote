import 'dart:typed_data';

import 'package:alh_pdf_view/lib.dart';
import 'package:dropnote/api/docs.dart';
import 'package:flutter/material.dart';

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

  __PDFLargeState createState() => __PDFLargeState();
}

class __PDFLargeState extends State<_PDFLarge> with WidgetsBindingObserver {
  // int? pages = 0;
  // int? currentPage = 0;
  // bool isReady = false;
  // String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return AlhPdfView(
      bytes: widget.pdfData,
      swipeHorizontal: false,

      // fitEachPage: true,
      // enableSwipe: true,
      // autoSpacing: false,
      // pageFling: true,
      // pageSnap: true,
      // defaultPage: currentPage!,
      // fitPolicy: FitPolicy.width,
      // onRender: (_pages) {
      //   setState(() {
      //     pages = _pages;
      //     isReady = true;
      //   });
      // },
      // onError: (error) {
      //   setState(() {
      //     errorMessage = error.toString();
      //   });
      // },
      // onPageError: (page, error) {
      //   setState(() {
      //     errorMessage = '$page: ${error.toString()}';
      //   });
      // },
      // onPageChanged: (int? page, int? total) {
      //   setState(() {
      //     currentPage = page;
      //   });
      // },
    );
  }
}

// TODO: Implement the small pdf viewer (for the file previews)

class _PDFSmall extends StatefulWidget {
  const _PDFSmall({super.key});

  @override
  State<_PDFSmall> createState() => __PDFSmallState();
}

class __PDFSmallState extends State<_PDFSmall> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
