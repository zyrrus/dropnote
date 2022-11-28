import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class LinkText extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const LinkText(this.text, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: DropNote.textStyles.p.copyWith(
          color: DropNote.colors.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
