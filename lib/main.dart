import 'package:flutter/material.dart';
import 'package:myapp/models/TodoScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: '',
      home: TodoScreen(),          
    );
    return materialApp;
  }
}