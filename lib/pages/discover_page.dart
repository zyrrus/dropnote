import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:dropnote/widgets/profile_list_item.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Discover",
          style: DropNote.textStyles.pageHeader(),
        ),
        ProfileListItem(
          professorName: "Nash Mahmoud",
          schoolName: "Louisiana State University",
        )
      ],
    );
  }
}
