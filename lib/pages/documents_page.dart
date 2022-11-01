import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Documents Page",
          style: DropNote.textStyles.pageHeader(),
        )
      ],
    );
  }
}
