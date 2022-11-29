import 'dart:async';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:dropnote/theme.dart';

const dftSearchText = [];

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmit;
  final FocusNode? textFocusNode;

  const SearchBar({
    super.key,
    required this.controller,
    this.onSubmit,
    this.textFocusNode,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List<String> animatedText = [
    "Search for documents",
    "Search for schools",
    "Search for people",
    "Search for tags"
  ];
  int animationIndex = 0;
  Timer? timer;

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
    return TextInputField(
      controller: widget.controller,
      label: animatedText[animationIndex],
      prefixIcon: Icon(
        Icons.search,
        color: DropNote.colors.foreground,
      ),
    );
  }
}
