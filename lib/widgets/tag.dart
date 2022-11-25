import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class Tag extends StatelessWidget {
  final String tagName;

  const Tag(this.tagName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: DropNote.colors.lightGrey,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Text(
        tagName,
        style: DropNote.textStyles.main(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
