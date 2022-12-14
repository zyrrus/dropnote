import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class DNTextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool isPrimary;
  final double? width;

  const DNTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 40.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: isPrimary ? DropNote.colors.primary : DropNote.colors.grey,
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(text, style: DropNote.textStyles.h3),
      ),
    );
  }
}
