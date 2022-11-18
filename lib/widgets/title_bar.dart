import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final Widget? suffixIcon;
  final bool isLarge;

  const TitleBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.suffixIcon,
    this.isLarge = true,
  });

  Widget getTitle() => Text(
        title,
        style: isLarge ? DropNote.textStyles.h1() : DropNote.textStyles.h2(),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DropNote.pagePadding,
        vertical: 17.0,
      ),
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

class SubtitleBar extends StatelessWidget {
  final String title;
  final void Function()? onIconPressed;

  const SubtitleBar({
    super.key,
    required this.title,
    this.onIconPressed,
  });

  Widget? getIcon() {
    if (onIconPressed is void Function()) {
      return DNIconButton(
        icon: Icons.arrow_forward_ios_rounded,
        onTap: onIconPressed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TitleBar(
      title: title,
      suffixIcon: getIcon(),
      isLarge: false,
    );
  }
}
