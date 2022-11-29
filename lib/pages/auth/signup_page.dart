import 'package:dropnote/api/users.dart';
import 'package:dropnote/main.dart';
import 'package:dropnote/theme.dart';
import 'package:dropnote/widgets/bar.dart';
import 'package:dropnote/widgets/link_text.dart';
import 'package:dropnote/widgets/text_button.dart';
import 'package:dropnote/widgets/text_input_field.dart';
import 'package:dropnote/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final void Function() togglePage;

  const SignUpPage({super.key, required this.togglePage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signup() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      var email = emailController.text.trim().toLowerCase();
      var password = passwordController.text.trim();
      var name = nameController.text.trim();
      var school = schoolController.text.trim();

      await UserAPI.signup(email, password, name, school);

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleBar(title: "Sign Up"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: Text("Welcome to DropNote.", style: DropNote.textStyles.p),
        ),
        const Bar(),
        const SubtitleBar(title: "Name"),
        TextInputField(label: "Name", controller: nameController),
        const SizedBox(height: 15.0),
        const SubtitleBar(title: "School"),
        TextInputField(label: "School", controller: schoolController),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Already have an account? ", style: DropNote.textStyles.p),
              LinkText("Sign in", onTap: widget.togglePage),
            ],
          ),
        ),
        const SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: DropNote.pagePadding),
          child: DNTextButton(
            text: "Sign Up",
            onTap: signup,
          ),
        ),
      ],
    );
  }
}
