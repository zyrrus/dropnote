import 'package:alh_pdf_view/lib.dart';
import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ViewFilePage extends StatelessWidget {
  final String name;
  final Uint8List data;
  final bool isPreview;

  const ViewFilePage({
    super.key,
    required this.name,
    required this.data,
    this.isPreview = false,
  });

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: Column(
        children: [
          TitleBar(
            title: name,
            showBackButton: true,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: DropNote.colors.lightGrey,
                  borderRadius: BorderRadius.circular(8.0)),
              child: FileViewer(fileData: data),
            ),
          ),
        ],
      ),
    );
  }
}

class FileViewer extends StatefulWidget {
  final Uint8List fileData;

  const FileViewer({Key? key, required this.fileData}) : super(key: key);

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return AlhPdfView(
      bytes: widget.fileData,
      swipeHorizontal: false,
      fitEachPage: true,
      autoSpacing: true,
      // defaultZoomFactor: 0.9,
      fitPolicy: FitPolicy.width,
      backgroundColor: DropNote.colors.clear,
      // enableSwipe: true,

      onPageChanged: (page, total) {
        // if page >= previewPages then
        // enableSwipe: false
        // this will probably result in the user not being able to swipe up
        // (so no swiping at all, but that's fine for the demo )
      },
    );
  }
}
