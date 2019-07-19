import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants.dart';

class Bubble extends StatefulWidget {
  final Color color;
  final Alignment alignment;
  final Text child;
  final DateTime date;

  Bubble(
      {this.color,
      this.alignment = Alignment.bottomCenter,
      this.child,
      this.date});

  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: InkWell(
        onTap: () {
          setState(() {
            isTap = !isTap;
          });
        },
        child: Column(
          crossAxisAlignment: widget.alignment == Alignment.centerRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                  minWidth: 10.0,
                  maxWidth: MediaQuery.of(context).size.width - 100.0),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: widget.alignment == Alignment.centerRight
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0))
                    : BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
              ),
              child: widget.child,
            ),
            isTap ? Text(timeago.format(widget.date)) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
