import 'package:flutter/widgets.dart';

import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Profile Page",
          style: DropNote.textStyles.pageHeader(),
        )
      ],
    );
  }
}
