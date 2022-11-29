import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const HorizontalList({
    super.key,
    required this.children,
    this.spacing = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(
                  left: (e.key == 0) ? DropNote.pagePadding : 0.0,
                  right: spacing,
                ),
                child: e.value,
              ),
            )
            .toList(),
      ),
    );
  }
}

class AsyncHorizontalList extends StatelessWidget {
  final Future<List<Widget>> Function() source;

  const AsyncHorizontalList({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
        future: source(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HorizontalList(children: snapshot.data!);
          }
          return const Center(
            child: SizedBox.square(
              dimension: 100.0,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
