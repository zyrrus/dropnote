import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        decoration: BoxDecoration(
          color: DropNote.colors.lightGrey,
          borderRadius: BorderRadius.circular(99.0),
        ),
      ),
    );
  }
}
