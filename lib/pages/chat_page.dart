import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/models/chat_model.dart';
import 'package:firebase_chat/models/msg_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_chat/widgets/bubble.dart';
import 'package:firebase_chat/models/user_model.dart';

class ChatPage extends StatefulWidget {
  static const id = '/chat';
  final Chat chat;

  ChatPage({this.chat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var _controller = TextEditingController();

  List<Msg> msgs = [];
  var _firestore = Firestore.instance;
  var _snapshot;

  @override
  void initState() {
    super.initState();
    _firestore.settings(timestampsInSnapshotsEnabled: true, sslEnabled: true);
    _snapshot = _firestore
        .collection('groupchats')
        .document(widget.chat.chatDocID)
        .collection('content')
        .orderBy('date')
        .limit(5)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _snapshot,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator(radius: 50.0)
                          : CircularProgressIndicator(strokeWidth: 20.0));
                }

                msgs.clear();
                var data = snapshot.data.documents;
                for (var doc in data) msgs.add(Msg.fromJson(doc.data));

                msgs = msgs.reversed.toList();
                return ListView.separated(
                  reverse: true,
                  itemCount: msgs.length,
                  padding: EdgeInsets.all(10.0),
                  separatorBuilder: (context, index) => SizedBox(height: 10.0),
                  itemBuilder: (context, index) {
                    bool isUidEqual = msgs[index].uid == User.uid;
                    return Bubble(
                      color: isUidEqual ? Colors.lightBlue : Colors.red,
                      alignment: isUidEqual
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      date: msgs[index].date,
                      child: Text(
                        msgs[index].text,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: GestureDetector(
              child: Icon(Icons.add_photo_alternate),
              onTap: () {},
            ),
            title: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Type your message here...',
                  contentPadding: EdgeInsets.all(10.0)),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.send,
                color: Colors.blue,
              ),
              onTap: () {
                _firestore
                    .collection('groupchats')
                    .document(widget.chat.chatDocID)
                    .collection('content')
                    .add({
                  'date': DateTime.now(),
                  'uid': User.uid,
                  'text': _controller.text,
                });
                setState(() {
                  _controller.clear();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
