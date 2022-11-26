import 'package:dropnote/pages/auth/auth_page.dart';
import 'package:dropnote/pages/core/debug_page.dart';
import 'package:dropnote/pages/core/discover_page.dart';
import 'package:dropnote/pages/core/documents_page.dart';
import 'package:dropnote/pages/core/notification_page.dart';
import 'package:dropnote/pages/core/profile_page.dart';
import 'package:dropnote/widgets/bottom_tab_navigator.dart';
import 'package:flutter/material.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  bool isAuthenticated = true;
  int _selectedPageIndex = 0;

  final List<Widget> _pages = const [
    DiscoverPage(),
    DocumentsPage(),
    NotificationPage(),
    ProfilePage(),
    DebugPage(),
  ];

  void changePage(int i) => setState(() => _selectedPageIndex = i);

  @override
  Widget build(BuildContext context) {
    return (isAuthenticated)
        ? CoreTemplate(
            bottomTab: BottomTabNavigation(
              selectedIndex: _selectedPageIndex,
              onTap: changePage,
            ),
            // child: IndexedStack(index: _selectedPageIndex, children: _pages),
            child: _pages[_selectedPageIndex],
          )
        : CoreTemplate(child: AuthPage());
  }
}

class CoreTemplate extends StatelessWidget {
  final Widget child;
  final Widget? bottomTab;

  const CoreTemplate({super.key, required this.child, this.bottomTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomTab,
      body: SafeArea(child: child),
    );
  }
}
