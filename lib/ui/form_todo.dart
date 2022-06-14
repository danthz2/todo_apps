import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/theme.dart';

class FormTodo extends StatelessWidget {
  final db = FirebaseFirestore.instance.collection('todo');
  final titleC = TextEditingController();
  final descC = TextEditingController();
  final date = DateTime.now();

  void addData(BuildContext context) async {
    final prov = Provider.of<TodoProvider>(context, listen: false);

    try {
      if (descC.text != '' && titleC.text != '') {
        final data = TodoModel(
          title: titleC.text,
          desc: descC.text,
          date: date,
          status: false,
        );
        prov.addData(data);
        descC.clear();
        titleC.clear();
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Form To Do")),
      body: Padding(
        padding: EdgeInsets.all(defPadd),
        child: Card(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defPadd),
            padding: EdgeInsets.only(bottom: 30, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Let's To Do",
                  style: titleWhite,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    controller: titleC,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      fillColor: white,
                      filled: true,
                    ),
                    style: TextStyle(color: black),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descC,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    fillColor: white,
                    filled: true,
                  ),
                  style: TextStyle(color: black),
                  maxLines: 6,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => addData(context),
                    child: Text(
                      "Simpan",
                      style: titleTeal.copyWith(fontSize: 14),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
