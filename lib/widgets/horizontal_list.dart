import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

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
