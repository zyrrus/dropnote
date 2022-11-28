import 'package:dropnote/pages/auth/auth_page.dart';
import 'package:dropnote/pages/core/debug_page.dart';
import 'package:dropnote/pages/core/discover_page.dart';
import 'package:dropnote/pages/core/documents_page.dart';
import 'package:dropnote/pages/core/notification_page.dart';
import 'package:dropnote/pages/core/profile_page.dart';
import 'package:dropnote/widgets/bottom_tab_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  State<CorePage> createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  bool overrideAuth = false;
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (overrideAuth || snapshot.hasData) {
          return CoreTemplate(
            bottomTab: BottomTabNavigation(
              selectedIndex: _selectedPageIndex,
              onTap: changePage,
            ),
            child: IndexedStack(index: _selectedPageIndex, children: _pages),
            // child: _pages[_selectedPageIndex],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        return const CoreTemplate(child: AuthPage());
      },
    );
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
