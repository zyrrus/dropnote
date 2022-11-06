import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:dropnote/widgets/search_bar.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discover",
          style: DropNote.textStyles.pageHeader(),
        ),
        SearchBar(
          controller: TextEditingController(),
        )
      ],
    );
  }
}
