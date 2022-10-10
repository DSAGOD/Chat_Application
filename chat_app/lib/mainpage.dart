import 'package:chat_app/chatPage.dart';
import 'package:chat_app/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeTalk",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Home"),
                  value: "Home",
                ),
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                // ignore: prefer_const_constructors
                PopupMenuItem(
                  child: Text("Profile"),
                  value: "Profile",
                ),
                PopupMenuItem(
                  child: Text("Logout"),
                  value: "Logout",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              text: "CHATS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ChatPage(),
        ],
      ),
      drawer: MyDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print("hello");
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
