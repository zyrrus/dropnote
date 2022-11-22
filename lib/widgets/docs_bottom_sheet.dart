import 'package:flutter/material.dart';

class DocsBottomSheet extends StatelessWidget {
  const DocsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('BottomSheet'),
          ],
        ),
      ),
    );
  }
}
