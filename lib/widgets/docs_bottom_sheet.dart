import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class DocsBottomSheet extends StatelessWidget {
  const DocsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: EdgeInsets.only(
          top: 58.0,
          left: DropNote.pagePadding,
          right: DropNote.pagePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BottomSheet'),
          ],
        ),
      ),
    );
  }
}
