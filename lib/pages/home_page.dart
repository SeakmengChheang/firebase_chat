import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/models/chat_model.dart';
import 'package:firebase_chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/widgets/chat_thread.dart';

class HomePage extends StatefulWidget {
  static const id = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _firestore = Firestore.instance;
  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();
    getChatThreads();
  }

  getChatThreads() async {
    var groupChats = _firestore.collection('groupchats');
    chats.clear();

    //Get every groupChat
    for (String id in User.chatId) {
      var content = await groupChats
          .document(id)
          .collection('content')
          .orderBy('date', descending: true)
          .limit(1)
          .getDocuments();

      // Get 2 people in the groupChat
      // Decide which info to show between 2 people
      var members = await groupChats.document(id).get();
      int index;
      if (members.data['members'][0]['uid'] == User.uid)
        index = 1;
      else
        index = 0;

      chats.add(Chat(
        name: members.data['members'][index]['name'],
        chatDocID: id,
        imageUrl: members.data['members'][index]['imageUrl'],
        uid: content.documents[0].data['sender_uid'],
        text: content.documents[0].data['text'],
        date: content.documents[0].data['date'].toDate(),
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu, size: 30.0),
                    onPressed: () {
                      getChatThreads();
                    },
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(User.imageUrl),
                    radius: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) => ChatThread(chats[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
