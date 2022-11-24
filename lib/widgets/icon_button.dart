import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class DNIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final bool isLarge;

  const DNIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 35.0,
      child: FloatingActionButton(
        heroTag: UniqueKey(),
        backgroundColor: DropNote.colors.primary,
        foregroundColor: DropNote.colors.foreground,
        onPressed: onTap,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        child: Icon(icon, size: 20.0),
      ),
    );
  }
}
