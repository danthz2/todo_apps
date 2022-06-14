import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/services/theme.dart';
import 'package:todo_app/ui/edit_todo.dart';
import 'package:todo_app/ui/form_todo.dart';
import 'package:todo_app/ui/homepage.dart';
import 'package:todo_app/ui/todo_done.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: teal,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: teal,
          ),
          cardTheme: CardTheme(
            color: teal,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: white, fixedSize: Size(80, 20)),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/form_todo': (context) => FormTodo(),
          '/edit_todo': (context) => EditTodo(),
          '/todo_done': (context) => TodoDone(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
