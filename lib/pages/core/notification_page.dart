import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Notifications",
          style: DropNote.textStyles.main(),
        )
      ],
    );
  }
}
