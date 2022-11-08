import 'package:dropnote/pages/core_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/top_bar.dart';
import 'package:flutter/material.dart';

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
          TopBar(
            title: "Test Page",
            showBackButton: true,
            suffixIcon: Icon(
              Icons.settings_outlined,
              size: 30.0,
              color: DropNote.colors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
