import 'package:flutter/material.dart';
import 'user_type_selection.dart';

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
      home: UserTypeSelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
