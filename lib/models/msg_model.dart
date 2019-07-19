import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  String uid;
  String text;
  DateTime date;

  Msg();

  factory Msg.fromJson(Map<String, dynamic> map) {
    Msg msg = Msg();
    msg.uid = map['uid'];
    msg.text = map['text'];
    msg.date = (map['date'] as Timestamp).toDate();
    return msg;
  }
}
