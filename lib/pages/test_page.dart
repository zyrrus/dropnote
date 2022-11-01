import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Test Page",
          style: DropNote.textStyles.pageHeader(),
        )
      ],
    );
  }
}
