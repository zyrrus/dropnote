import 'package:flutter/material.dart';
import 'package:dropnote/theme.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;

  const SearchBar({super.key, required this.controller});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color focusedColor = DropNote.colors.grey;
  bool showClearButton = false;

  void updateFocusedColor(bool hasFocus) {
    setState(() {
      focusedColor =
          hasFocus ? DropNote.colors.foreground : DropNote.colors.grey;
    });
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
            fillColor: DropNote.colors.grey,
            isCollapsed: true,
            prefixIcon: Icon(
              Icons.search,
              color: DropNote.colors.foreground,
            ),
            alignLabelWithHint: true,
            hintText: "Search for documents",
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
                color: DropNote.colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: DropNote.colors.grey,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
