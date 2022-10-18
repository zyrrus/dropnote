// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (const bool.fromEnvironment("USE_FIREBASE_EMU")) {
    await _configureFirebaseAuth();
    await _configureFirebaseStorage();
    _configureFirebaseFirestore();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

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

// === Emulator setup ==========================================================

Future<void> _configureFirebaseAuth() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("AUTH_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9099;
  await FirebaseAuth.instance.useAuthEmulator(host, port);
  debugPrint('Using Firebase Auth emulator on: $host:$port');
}

Future<void> _configureFirebaseStorage() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("STORAGE_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9199;
  await FirebaseStorage.instance.useStorageEmulator(host, port);
  debugPrint('Using Firebase Storage emulator on: $host:$port');
}

void _configureFirebaseFirestore() {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("DB_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 8080;

  FirebaseFirestore.instance.settings = Settings(
    host: '$host:$port',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  debugPrint('Using Firebase Firestore emulator on: $host:$port');
}
