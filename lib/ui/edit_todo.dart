import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/theme.dart';

class EditTodo extends StatelessWidget {
  final db = FirebaseFirestore.instance.collection('todo');
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();
  final date = DateTime.now();

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataById(String id) async {
    var data = await db.doc(id).get();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("Form To Do")),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getDataById(arg),
        builder: (context, snapshot) {
          var data = snapshot.data;
          print(data?['title']);
          if (snapshot.connectionState == ConnectionState.done) {
            return editCard(context, data?['title'], data?['desc'], arg);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Padding editCard(BuildContext context, String title, String desc, String id) {
    titleC.text = title;
    descC.text = desc;
    return Padding(
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
                "title",
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
                  onPressed: () async {
                    var data = {
                      'title': titleC.text,
                      'desc': descC.text,
                      'date': date,
                      'dateString': date.toIso8601String(),
                      'dateEpoch': date.millisecondsSinceEpoch,
                      'status': false,
                    };
                    if (descC.text != '' && titleC.text != '') {
                      await db.doc(id).set(data);
                      descC.clear();
                      titleC.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Simpan",
                    style: titleTeal.copyWith(fontSize: 14),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
