// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropNote {
  static final _Colors colors = _Colors();
  static final _TextStyles textStyles = _TextStyles();
  static final _Decorations commonDecorations = _Decorations();
}

class _Colors {
  final Color foreground = const Color(0xff383747);
  final Color background = const Color(0xffF7F7F8);
  final Color disabled = const Color(0x33383747);
  final Color primary = const Color(0xff897EA5);
  final Color secondary = const Color(0xffCFB9A5);
}

class _TextStyles {
  final header = GoogleFonts.syne;
  final body = GoogleFonts.workSans;

  // === Commonly used text styles =============================================
  TextStyle pageHeader() => header(
        color: DropNote.colors.foreground,
        fontWeight: FontWeight.w500,
        fontSize: 40.0,
        fontFeatures: const [FontFeature.disable('liga')],
      );

  TextStyle tabLabel() => header(
        color: DropNote.colors.foreground,
        fontSize: 20.0,
        fontFeatures: const [FontFeature.disable('liga')],
      );

  TextStyle label({Color? color}) => header(
        color: color ?? DropNote.colors.foreground,
        fontSize: 22.0,
        fontFeatures: const [FontFeature.disable('liga')],
      );

  TextStyle placeholder({Color? color}) => header(
        color: color ?? DropNote.colors.disabled,
        fontSize: 24.0,
        fontFeatures: const [FontFeature.disable('liga')],
      );

  TextStyle fileTitle() => header(
        color: DropNote.colors.background,
        fontSize: 24.0,
      );

  TextStyle fileSubtext({Color? color}) => header(
        color: color ?? DropNote.colors.background,
        fontSize: 18.0,
      );

  TextStyle fileTags() => header(
        color: DropNote.colors.background,
        fontSize: 14.0,
      );
}

class _Decorations {
  InputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: DropNote.colors.foreground,
      width: 1.0,
    ),
  );

  InputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: DropNote.colors.primary,
      width: 2.0,
    ),
  );

  InputDecoration fieldDecoration({
    required String label,
    required Color focusedColor,
    String? placeholder,
  }) =>
      InputDecoration(
        iconColor: focusedColor,
        suffixIconColor: focusedColor,
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(10.0),
        label: Text(
          label,
          style: DropNote.textStyles.label(color: focusedColor),
        ),
        hintText: placeholder ?? label,
        hintStyle: DropNote.textStyles.placeholder(),
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      );
}
