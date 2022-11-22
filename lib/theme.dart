// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropNote {
  static final _Colors colors = _Colors();
  static final _TextStyles textStyles = _TextStyles();
  static final _Decorations commonDecorations = _Decorations();

  // === Constants =============================================================

  static double pagePadding = 20.0;
}

class _Colors {
  final Color foreground = Colors.black;
  final Color background = Colors.white;
  final Color lightGrey = const Color.fromRGBO(230, 230, 230, 1);
  final Color grey = const Color.fromRGBO(210, 210, 210, 1);
  final Color darkGrey = const Color.fromRGBO(160, 160, 160, 1);
  final Color primary = const Color(0xFFF5BA62);
  final Color clear = const Color(0x00000000);
}

class _TextStyles {
  final main = GoogleFonts.inter;

  // === Commonly used text styles =============================================

  TextStyle h1() => main(
        color: DropNote.colors.foreground,
        fontWeight: FontWeight.w600,
        fontSize: 32,
      );

  TextStyle h2() => main(fontWeight: FontWeight.w600, fontSize: 24);
}

class _Decorations {}
