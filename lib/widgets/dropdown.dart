import 'dart:math' as math;
import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> items;
  final void Function(String?)? onSelectionChanged;

  const Dropdown({super.key, required this.items, this.onSelectionChanged});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Color focusedColor = DropNote.colors.foreground;
  String? value;

  void updateFocusedColor(bool hasFocus) {
    setState(() {
      focusedColor =
          hasFocus ? DropNote.colors.primary : DropNote.colors.foreground;
    });
  }

  void dropdownCallback(String? selected) {
    if (selected is String) {
      setState(() {
        value = selected;
      });
    }

    if (widget.onSelectionChanged != null) widget.onSelectionChanged!(selected);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: widget.items
          .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e,
                  style: DropNote.textStyles.placeholder(
                    color: DropNote.colors.foreground,
                  ))))
          .toList(),
      onChanged: dropdownCallback,
      value: value,
      isExpanded: true,
      decoration: DropNote.commonDecorations.fieldDecoration(
        label: "School",
        focusedColor: focusedColor,
      ),
      style: DropNote.textStyles.placeholder(),
      icon: Transform.rotate(
        angle: -90 * math.pi / 180,
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 22.0,
          color: focusedColor,
        ),
      ),
    );
  }
}
