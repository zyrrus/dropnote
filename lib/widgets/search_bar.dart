import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/text_input.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;

  const SearchBar({super.key, required this.controller});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color focusedColor = DropNote.colors.disabled;

  void updateFocusedColor(bool hasFocus) {
    setState(() {
      focusedColor =
          hasFocus ? DropNote.colors.foreground : DropNote.colors.disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: updateFocusedColor,
      child: TextField(
        controller: widget.controller,
        style: DropNote.textStyles.placeholder(color: focusedColor),
        cursorColor: DropNote.colors.primary,
        decoration: InputDecoration(
          isCollapsed: true,
          prefixIcon: Icon(
            Icons.search,
            color: focusedColor,
          ),
          contentPadding: const EdgeInsets.all(10.0),
          hintText: "Search...",
          hintStyle: DropNote.textStyles.placeholder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DropNote.colors.disabled,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DropNote.colors.foreground,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
