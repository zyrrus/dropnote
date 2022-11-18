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
  final Color lightGrey = const Color(0xFFD4D4D4);
  final Color grey = Color(0xFFBEBEBE);
  final Color darkGrey = Color.fromARGB(255, 172, 172, 172);
  final Color primary = const Color(0xffF5BA62);
  final Color clear = const Color(0x00000000);
}

class _TextStyles {
  final main = GoogleFonts.inter;

  // === Commonly used text styles =============================================

  TextStyle h1() => main(fontWeight: FontWeight.w600, fontSize: 32);

  TextStyle h2() => main(fontWeight: FontWeight.w600, fontSize: 24);
}

class _Decorations {}
