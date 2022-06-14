import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance.collection('todo');

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataFilter(
    String filter,
    bool isDone,
  ) {
    try {
      final listData = db.where(filter, isEqualTo: isDone).snapshots();
      return listData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addData(TodoModel data) async {
    try {
      db.doc().set(data.toMap());
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteData(String id) async {
    try {
      db.doc(id).delete();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
