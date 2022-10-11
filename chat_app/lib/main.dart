import 'package:chat_app/mainpage.dart';
import 'package:chat_app/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'already_have_an_account_check.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      home: mainLogin(),
      // initialRoute: 'login',
      routes: {
        "login": (BuildContext content) => new LoginPage(),
        "mainPg": (context) => MainPage(),
        "/RegisterPage": (BuildContext content) => new Registration(),
      },
    );
  }
}

class mainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              print("the data is ${snapshot.data}");
              if (snapshot.hasData) {
                return MainPage();
              } else {
                return LoginPage();
              }
            }),
      );
}
