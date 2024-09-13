import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputPage(tasks: []), // Start with an empty task list
    );
  }
}
