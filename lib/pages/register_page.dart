import 'package:firebase_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const id = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _buildButton({String text, Function onPressed}) {
    return Container(
      height: 50.0,
      child: RoundedButton(
        color: Colors.white,
        onPressed: onPressed,
        child: <Widget>[
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(text: 'Register', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
