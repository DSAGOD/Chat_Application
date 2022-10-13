import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return (SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        // leading:
        leading: IconButton(
          icon: Icon(Icons.logout_rounded),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, "login");
          },
        ),
      ),
    )));
  }
}
