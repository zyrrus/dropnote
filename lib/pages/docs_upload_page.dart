import 'package:dropnote/theme.dart';
import 'package:dropnote/pages/documents_page.dart';
import 'package:flutter/material.dart';

class DocsUploadPage extends StatelessWidget {
  const DocsUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    var border;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "Upload",
                    style: DropNote.textStyles.pageHeader(),
                  ),
                ],
              ),
              //TODO: add component
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffc0c0c0),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Number of preview pages",
                      style: DropNote.textStyles.label(),
                    ),
                    Text(
                      "1",
                      style: DropNote.textStyles.label(),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffc0c0c0),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Request-only",
                      style: DropNote.textStyles.label(),
                    ),
                    Icon(Icons.check_box_outline_blank),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                child: Row(
                  children: [
                    Text(
                      "Add Tags",
                      style: DropNote.textStyles.label(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
