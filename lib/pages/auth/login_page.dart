import 'package:dropnote/api/users.dart';
import 'package:dropnote/main.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/link_text.dart';
import 'package:dropnote/widgets/text_button.dart';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function() togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      var email = emailController.text.trim().toLowerCase();
      var password = passwordController.text.trim();

      await UserAPI.login(email, password);

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleBar(title: "Log In"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: Text("Welcome to DropNote.", style: DropNote.textStyles.p),
        ),
        const Bar(),
        const SubtitleBar(title: "Email"),
        TextInputField(label: "Email", controller: emailController),
        const SizedBox(height: 15.0),
        const SubtitleBar(title: "Password"),
        TextInputField(
          label: "Password",
          controller: passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot your password? ", style: DropNote.textStyles.p),
                  LinkText("Reset", onTap: () {}),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("New user? ", style: DropNote.textStyles.p),
                  LinkText("Sign up", onTap: widget.togglePage),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: DNTextButton(
            text: "Log In",
            onTap: login,
          ),
        ),
      ],
    );
  }
}
