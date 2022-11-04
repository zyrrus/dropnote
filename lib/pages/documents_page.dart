import 'package:dropnote/theme.dart';
import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});
  void uploadButtonPressed() {}
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
              onPressed: uploadButtonPressed,
              child: const Icon(
                Icons.add,
                size: 35.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TabBarView(
              children: [
                Text(
                  "Uploaded",
                  style: DropNote.textStyles.header(),
                ),
                Text(
                  "Saved",
                  style: DropNote.textStyles.header(),
                )
              ],
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
          labelStyle: DropNote.textStyles.header(fontSize: 20.0),
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
