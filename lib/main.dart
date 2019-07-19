import 'package:firebase_chat/pages/auth_pages.dart';
import 'package:firebase_chat/pages/chat_page.dart';
import 'package:firebase_chat/pages/home_page.dart';
import 'package:firebase_chat/pages/register_page.dart';
import 'package:firebase_chat/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DM Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        SignInPage.id: (context) => SignInPage(),
        ChatPage.id: (context) => ChatPage(),
        RegisterPage.id: (context) => RegisterPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}