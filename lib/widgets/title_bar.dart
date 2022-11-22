import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class _TitleBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final Widget? suffixIcon;
  final bool isLarge;

  const _TitleBar({
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: _TitleBar(
        title: title,
        showBackButton: showBackButton,
        suffixIcon: suffixIcon,
        isLarge: isLarge,
      ),
    );
  }
}

class SubtitleBar extends StatelessWidget {
  final String title;
  final void Function()? onIconPressed;
  final IconData? icon;

  const SubtitleBar({
    super.key,
    required this.title,
    this.onIconPressed,
    this.icon,
  });

  Widget? getIcon() {
    if (onIconPressed is void Function()) {
      return DNIconButton(
        icon: icon ?? Icons.arrow_forward_ios_rounded,
        onTap: onIconPressed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: _TitleBar(
        title: title,
        suffixIcon: getIcon(),
        isLarge: false,
      ),
    );
  }
}
