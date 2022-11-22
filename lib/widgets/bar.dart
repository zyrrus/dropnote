import 'package:dropnote/theme.dart';
import 'package:flutter/widgets.dart';

class Bar extends StatelessWidget {
  final bool noPadding;

  const Bar({super.key, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: noPadding ? 0.0 : 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 2.0,
        decoration: BoxDecoration(
          color: DropNote.colors.lightGrey,
          borderRadius: BorderRadius.circular(99.0),
        ),
      ),
    );
  }
}
