import 'package:dropnote/pages/auth/login_page.dart';
import 'package:dropnote/pages/auth/signup_page.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() => setState(() => showLoginPage = !showLoginPage);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (showLoginPage)
          ? LoginPage(togglePage: togglePages)
          : SignUpPage(togglePage: togglePages),
    );
  }
}
