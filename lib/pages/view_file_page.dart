import 'package:dropnote/pages/core/core_page.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ViewFilePage extends StatelessWidget {
  final String? name;
  final Uint8List? data;

  const ViewFilePage({super.key, this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return CoreTemplate(
      child: Column(
        children: [
          TitleBar(
            title: "TODO: ViewFilePage",
            showBackButton: true,
          ),
        ],
      ),
    );
  }
}
