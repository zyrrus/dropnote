import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Discover Page",
          style: DropNote.textStyles.pageHeader(),
        )
      ],
    );
  }
}
