import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter/material.dart';

import 'CustomUI/CustomCard.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: "Aditya Ugale",
      icon: "person.svg",
      isGroup: false,
      time: "4:00",
      currentMessage: "Hi Everyone",
    ),
    ChatModel(
      name: "Rishav Thapliyal",
      icon: "person.svg",
      isGroup: false,
      time: "8:00",
      currentMessage: "Hi Rishav",
    ),
    ChatModel(
      name: "Unofficial",
      icon: "groups.svg",
      isGroup: true,
      time: "6:00",
      currentMessage: "Hi Everyone",
    ),
    ChatModel(
      name: "Shantanu Rane",
      icon: "person.svg",
      isGroup: false,
      time: "4:00",
      currentMessage: "Hi Everyone",
    ),
    ChatModel(
      name: "We Friends",
      icon: "groups.svg",
      isGroup: true,
      time: "2:00",
      currentMessage: "Hi Buddies",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
        // itemBuilder: (context, index) => CustomCard(
        //   chatModel: chats[index],
      ),
    );
  }
}
