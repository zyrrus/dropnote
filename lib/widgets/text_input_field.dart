import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? prefixIcon;
  final void Function(String)? onSubmit;
  final FocusNode? textFocusNode;

  const TextInputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.prefixIcon,
    this.onSubmit,
    this.textFocusNode,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool showClearButton = false;

  void toggleClearIcon() {
    setState(() {
      showClearButton = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    widget.controller.addListener(toggleClearIcon);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(toggleClearIcon);
    super.dispose();
  }

  TextStyle textStyle() => DropNote.textStyles.h3;

  InputBorder border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: DropNote.colors.lightGrey,
          width: 2.0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
      child: SizedBox(
        height: 40.0,
        child: TextField(
          focusNode: widget.textFocusNode,
          onSubmitted: widget.onSubmit,
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          obscureText: widget.obscureText,
          obscuringCharacter: "•",
          style: textStyle(),
          cursorColor: DropNote.colors.primary,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15.0),
            filled: true,
            fillColor: DropNote.colors.lightGrey,
            isCollapsed: true,
            hintText: widget.label,
            hintStyle: textStyle(),
            suffixIcon: IconButton(
              onPressed: widget.controller.clear,
              icon: Icon(
                Icons.clear,
                color: (showClearButton)
                    ? DropNote.colors.foreground
                    : DropNote.colors.clear,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            enabledBorder: border(),
            focusedBorder: border(),
          ),
        ),
      ),
    );
  }
}
