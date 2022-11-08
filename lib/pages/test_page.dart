import 'dart:io';

import 'package:dropnote/api/docs.dart';
import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/pdf_viewer.dart';
import 'package:dropnote/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(TestPage());

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(title: "Test Page"),
        ],
      ),
    );
  }
}
