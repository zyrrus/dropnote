import 'package:dropnote/pages/discover_page.dart';
import 'package:dropnote/pages/documents_page.dart';
import 'package:dropnote/pages/notification_page.dart';
import 'package:dropnote/pages/profile_page.dart';
import 'package:dropnote/pages/test_page.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bottom_tab_navigator.dart';
import 'package:flutter/material.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  bool isAutenticated = true;
  int _selectedPageIndex = 0;

  final List<Widget> _pages = const [
    DiscoverPage(),
    DocumentsPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  void changePage(int i) => setState(() => _selectedPageIndex = i);

  @override
  Widget build(BuildContext context) {
    return (isAutenticated)
        ? Scaffold(
            bottomNavigationBar: BottomTabNavigation(
              selectedIndex: _selectedPageIndex,
              onTap: changePage,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                child: IndexedStack(
                  index: _selectedPageIndex,
                  children: _pages,
                ),
              ),
            ),
          )
        : TestPage(); // TODO: Login Page
  }
}
