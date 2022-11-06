import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:flutter/widgets.dart';

class FileCard extends StatefulWidget {
  final String url;
  final bool showPreview;

  const FileCard({
    super.key,
    required this.url,
    this.showPreview = true,
  });

  @override
  State<FileCard> createState() => _FileCardState();
}

class _FileCardState extends State<FileCard> {
  String fileName = "dropnote.pdf";
  String ownerName = "Drop Team";
  int saves = 4330;
  bool isRequestOnly = true;
  List<String> tags = ["Best", "Project", "Best", "Project", "Best", "Project"];

  // === Box Decorations =======================================================

  BoxDecoration _OutlineStyle() => BoxDecoration(
        color: DropNote.colors.background,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: DropNote.colors.secondary, width: 3.0),
      );

  BoxDecoration _FileCover() => BoxDecoration(
        color: DropNote.colors.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      );

  BoxDecoration _TagStyle() => BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: DropNote.colors.disabled,
          width: 2.0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.only(top: 20.0),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: _OutlineStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showPreview
                ? PDFSmall(url: widget.url)
                : const SizedBox(height: 5.0),
            CustomPaint(
              painter: FilePainter(),
              child: Container(
                decoration: _FileCover(),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fileName,
                          style: DropNote.textStyles.fileTitle(),
                        ),
                        Text(
                          ownerName,
                          style: DropNote.textStyles.fileSubtext(),
                        ),
                      ],
                    ),
                    isRequestOnly
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$saves Saves",
                                style: DropNote.textStyles.fileSubtext(
                                  color: DropNote.colors.disabled,
                                ),
                              ),
                              Text(
                                "(request-only)",
                                style: DropNote.textStyles.fileSubtext(
                                  color: DropNote.colors.disabled,
                                ),
                              )
                            ],
                          )
                        : Text(
                            "$saves Saves",
                            style: DropNote.textStyles.fileSubtext(),
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tags
                            .map((e) => Container(
                                  decoration: _TagStyle(),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    e,
                                    style: DropNote.textStyles.fileTags(),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = DropNote.colors.secondary
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 20.0;

    var path = Path();

    double largeWidth = 75.0;
    double shortwidth = 50.0;
    double height = 15.0;

    double xStep = (largeWidth - shortwidth) / 2.0;
    Offset origin = const Offset(8.0, 5.0);

    path.addPolygon(
      [
        origin + Offset(0.0, 2 * height),
        origin,
        origin + Offset(xStep, -height),
        origin + Offset(largeWidth - xStep, -height),
        origin + Offset(largeWidth, 0.0),
      ],
      true,
    );

    canvas.drawPath(path, paint);

    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
