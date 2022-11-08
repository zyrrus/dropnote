import 'package:dropnote/pages/docs_upload_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/file_card.dart';
import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  void uploadButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DocsUploadPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // animationDuration: Duration.zero,
      length: 2,
      child: Scaffold(
          appBar: DocumentsAppBar(),
          floatingActionButton: SizedBox.square(
            dimension: 75.0,
            child: FloatingActionButton(
              backgroundColor: DropNote.colors.primary,
              onPressed: () => uploadButtonPressed(context),
              child: const Icon(
                Icons.add,
                size: 35.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TabBarView(
              children: [UploadedTab(), SavedTab()],
            ),
          )),
    );
  }
}

AppBar DocumentsAppBar() => AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.white.withAlpha(0),
      title: Text(
        "Documents",
        style: DropNote.textStyles.pageHeader(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size(double.infinity, 25),
        child: TabBar(
          labelStyle: DropNote.textStyles.tabLabel(),
          labelColor: DropNote.colors.primary,
          labelPadding: EdgeInsets.zero,
          unselectedLabelColor: DropNote.colors.disabled,
          // indicatorWeight: 3.0,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: DropNote.colors.primary,
          tabs: const [
            Tab(height: 32.0, text: "Uploaded"),
            Tab(height: 32.0, text: "Saved")
          ],
        ),
      ),
    );

class UploadedTab extends StatelessWidget {
  const UploadedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [FileCard(filename: "dropteam-product-strategy.pdf")],
    );
  }
}

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileCard(filename: "dropteam-product-strategy.pdf", showPreview: false)
      ],
    );
  }
}
