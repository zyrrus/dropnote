// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DropNote {
  static final _Colors colors = _Colors();
  static final _TextStyles textStyles = _TextStyles();
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
      );
}
