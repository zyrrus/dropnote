import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final FloatingLabelBehavior? labelBehavior;
  final bool isPassword;

  const TextInput({
    super.key,
    required this.label,
    this.placeholder,
    this.isPassword = false,
    this.controller,
    this.labelBehavior,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  Color focusedColor = DropNote.colors.foreground;

  void updateFocusedColor(bool hasFocus) {
    setState(() {
      focusedColor =
          hasFocus ? DropNote.colors.primary : DropNote.colors.foreground;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: updateFocusedColor,
      child: TextField(
        obscureText: widget.isPassword,
        obscuringCharacter: "•",
        controller: widget.controller,
        style: DropNote.textStyles.placeholder(color: focusedColor),
        cursorColor: DropNote.colors.primary,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: DropNote.textStyles.label(color: focusedColor),
          ),
          hintText: widget.placeholder ?? widget.label,
          hintStyle: DropNote.textStyles.placeholder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DropNote.colors.foreground,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DropNote.colors.primary,
              width: 2.0,
            ),
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior:
              widget.labelBehavior ?? FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
