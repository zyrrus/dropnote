import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Core(children: []);
  }
}

class _Core extends StatelessWidget {
  final List<Widget>? children;

  const _Core({super.key, this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test Page",
                  style: DropNote.textStyles.pageHeader(),
                ),
                ...?children
              ]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: e,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
