import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? title;
  String? desc;
  bool? status;
  DateTime? date;

  TodoModel({this.title, this.desc, this.status, this.date});

  factory TodoModel.fromSnapshot(QuerySnapshot snapshot) {
    final value = snapshot as Map<String, dynamic>;
    return TodoModel.fromJson(value);
  }

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'status': status,
      'date': date,
    };
  }
}
