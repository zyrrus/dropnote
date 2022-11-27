import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dropnote/theme.dart';

const dftSearchText = [];

class SearchBar extends StatefulWidget {
  final TextEditingController controller;

  const SearchBar({super.key, required this.controller});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color focusedColor = DropNote.colors.lightGrey;
  bool showClearButton = false;
  final List<String> animatedText = [
    "Search for documents",
    "Search for schools",
    "Search for people",
    "Search for tags"
  ];
  int animationIndex = 0;
  Timer? timer;

  void updateFocusedColor(bool hasFocus) {
    setState(() {
      focusedColor =
          hasFocus ? DropNote.colors.foreground : DropNote.colors.lightGrey;
    });
  }

  void updateAnimationIndex() {
    setState(() {
      if (animationIndex < animatedText.length - 1) {
        animationIndex++;
      } else {
        animationIndex = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => updateAnimationIndex());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: SizedBox(
        height: 40.0,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          style: DropNote.textStyles.main(
            color: DropNote.colors.foreground,
            fontWeight: FontWeight.w600,
          ),
          cursorColor: DropNote.colors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: DropNote.colors.lightGrey,
            isCollapsed: true,
            prefixIcon: Icon(
              Icons.search,
              color: DropNote.colors.foreground,
            ),
            alignLabelWithHint: true,
            hintText: animatedText[animationIndex],
            suffixIcon: IconButton(
              onPressed: widget.controller.clear,
              icon: Icon(
                Icons.clear,
                color: DropNote.colors.foreground,
              ),
            ),
            hintStyle: DropNote.textStyles.main(
              fontWeight: FontWeight.w600,
              color: DropNote.colors.foreground,
              fontSize: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: DropNote.colors.lightGrey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: DropNote.colors.lightGrey,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
