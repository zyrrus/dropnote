import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final Widget? suffixIcon;

  const TopBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.suffixIcon,
  });

  Widget getTitle() => Text(
        title,
        style: DropNote.textStyles.pageHeader(),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (showBackButton)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30.0,
                        color: DropNote.colors.foreground,
                      ),
                    ),
                    getTitle(),
                  ],
                )
              : getTitle(),
          if (suffixIcon != null) suffixIcon!,
          // suffix icon?
        ],
      ),
    );
  }
}
