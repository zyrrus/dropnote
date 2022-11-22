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
    return Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: DropNote.colors.primary,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20.0),
        onPressed: onTap,
      ),
    );
  }
}
