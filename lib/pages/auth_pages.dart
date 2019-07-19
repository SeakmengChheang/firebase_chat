import 'package:firebase_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'register_page.dart';
import 'sign_in_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              child: RoundedButton(
                color: Colors.lightBlue,
                child: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  )
                ],
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
              ),
            ),
            SizedBox(height: 25.0),
            Container(
              height: 50.0,
              child: RoundedButton(
                color: Colors.red[500],
                child: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  )
                ],
                onPressed: () => Navigator.pushNamed(context, SignInPage.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
