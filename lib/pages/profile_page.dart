import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Profile",
          style: DropNote.textStyles.pageHeader(),
        )
      ],
    );
  }
}
