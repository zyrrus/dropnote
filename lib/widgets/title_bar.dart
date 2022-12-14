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
    void Function()? onTap,
  });

  Widget getTitle() => Text(
        title,
        style: isLarge ? DropNote.textStyles.h1 : DropNote.textStyles.h2,
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
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: DropNote.colors.primary,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 20.0,
                          color: DropNote.colors.foreground,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 15)),
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
  final void Function()? onIconPressed;

  const TitleBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.suffixIcon,
    this.isLarge = true,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, top: 20, bottom: 20),
      child: _TitleBar(
        title: title,
        showBackButton: showBackButton,
        suffixIcon: suffixIcon,
        isLarge: isLarge,
        onTap: onIconPressed,
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
