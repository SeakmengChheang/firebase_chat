import 'package:firebase_chat/models/chat_model.dart';
import 'package:firebase_chat/pages/chat_page.dart';
import 'package:flutter/material.dart';

class ChatThread extends StatelessWidget {
  final Chat chat;

  ChatThread(this.chat);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(chat.imageUrl),
          ),
          title: Text(chat.name),
          subtitle: Text(chat.text),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(chat: chat),
              ),
            );
          },
        ),
        SizedBox(
          height: 1.0,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(left: 75.0),
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
