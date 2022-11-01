import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("DropNote"),
              TextField(
                decoration: InputDecoration(
                  label: Text("Email"),
                  hintText: "Enter an email",
                ),
                controller: _emailController,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text("Password"),
                  hintText: "Enter a password",
                ),
                obscureText: true,
                controller: _passwordController,
              ),
              ElevatedButton(onPressed: logIn, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Logged in")),
          ElevatedButton(
              onPressed: FirebaseAuth.instance.signOut,
              child: Text("Sign out")),
        ],
      ),
    );
  }
}
