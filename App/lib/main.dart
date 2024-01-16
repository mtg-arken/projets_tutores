import 'package:flutter/material.dart';
import 'President_jury/accuil_president.dart';
import 'Common_Pages/login_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tribunal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccueilPresidentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
