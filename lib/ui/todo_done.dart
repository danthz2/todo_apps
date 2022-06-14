import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/theme.dart';

class TodoDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TodoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Todo Apps")),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                "Todo List Finished",
                style: descTeal,
              )),
          StreamBuilder<QuerySnapshot>(
              stream: prov.getDataFilter('status', false),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something Wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading.."),
                    ],
                  ));
                }

                return Column(
                    children: snapshot.data!.docs.map(
                  (e) {
                    var data = e.data() as Map<String, dynamic>;
                    return todoCard(
                        context, size, data['title'], data['desc'], e.id);
                  },
                ).toList());
              }),
        ],
      ),
    );
  }

  Container todoCard(
      BuildContext context, Size size, String title, String desc, String id) {
    final prov = Provider.of<TodoProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      width: size.width,
      height: 100,
      child: Card(
        elevation: 2,
        child: ListTile(
          onTap: () =>
              Navigator.pushNamed(context, '/edit_todo', arguments: id),
          trailing: SizedBox(
            height: size.height,
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      print("klik");
                    },
                    icon: Icon(
                      Icons.repeat,
                      color: white,
                    )),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Hapus Data",
                            style: titleTeal,
                          ),
                          content: Text(
                            "Apakah yakin ingin menghapus?",
                            style: descTeal,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: descTeal,
                                )),
                            TextButton(
                                onPressed: () {
                                  prov.deleteData(id);
                                  Navigator.pop(context);
                                },
                                child: Text("Yes", style: descTeal)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
          title: Text(
            title,
            style: titleWhite,
            overflow: TextOverflow.fade,
          ),
          subtitle: Text(
            desc,
            style: descWhite,
          ),
        ),
      ),
    );
  }
}
