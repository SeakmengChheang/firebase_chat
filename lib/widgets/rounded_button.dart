import 'package:firebase_chat/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final List<Widget> child;
  final Function onPressed;
  final MainAxisAlignment mainAxisAlignment;

  RoundedButton(
      {this.color,
      this.child,
      this.onPressed,
      this.mainAxisAlignment = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: child,
      ),
    );
  }
}
