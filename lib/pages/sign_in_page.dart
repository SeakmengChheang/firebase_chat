import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/models/user_model.dart';
import 'package:firebase_chat/pages/home_page.dart';
import 'package:firebase_chat/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'chat_page.dart';

class SignInPage extends StatefulWidget {
  static const id = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _auth = FirebaseAuth.instance;
  bool doingWork = false;

  _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.7],
        ),
      ),
    );
  }

  _buildButton({String imageUrl, String text, Function onPressed}) {
    return Container(
      height: 50.0,
      child: RoundedButton(
        color: Colors.white,
        onPressed: onPressed,
        child: <Widget>[
          Image.asset(
            imageUrl,
            width: 25.0,
          ),
          SizedBox(width: 25.0),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: doingWork,
        progressIndicator: Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),
        child: Stack(
          children: <Widget>[
            _buildBackground(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius)),
                        hintText: 'Input email address',
                        fillColor: Colors.white,
                        filled: true),
                    onChanged: (s) => User.email = s,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius)),
                        hintText: 'Input password',
                        fillColor: Colors.white,
                        filled: true),
                    onChanged: (s) => User.pw = s,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    height: 50.0,
                    child: RoundedButton(
                      child: <Widget>[Text('Sign In')],
                      color: Colors.white,
                      onPressed: () async {
                        setState(() {
                          doingWork = true;
                        });
                        var resUser = await _auth
                            .signInWithEmailAndPassword(
                                email: User.email, password: User.pw)
                            .catchError((e) {
                          print(e);
                        });

                        if (resUser != null) {
                          //Get user's data
                          var userData = await Firestore.instance
                              .collection('users')
                              .where('uid', isEqualTo: User.uid)
                              .getDocuments();
                          User.imageUrl = userData.documents[0]
                              .data['imageUrl'];
                          User.name = userData.documents[0]
                              .data['name'];
                          User.chatId = userData.documents[0]
                              .data['chat_id'];

                          User.uid = resUser.uid;
                          Navigator.pushNamed(context, HomePage.id);
                        }
                        setState(() {
                          doingWork = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 35.0),
                  Column(
                    children: <Widget>[
                      _buildButton(
                        imageUrl: 'assets/logos/google.png',
                        text: 'Sign In with Google',
                        onPressed: () {},
                      ),
                      SizedBox(height: 15.0),
                      _buildButton(
                        imageUrl: 'assets/logos/facebook.jpg',
                        text: 'Sign In with Facebook',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
