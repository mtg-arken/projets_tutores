import 'package:flutter/material.dart';
import 'Common_Pages/login_Page.dart';
import 'juge/accueil_juge.dart';
import 'president_Jury/accueil_president.dart';

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
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/president': (context) => AccueilPresident(),
        '/juge': (context) => AccueilJuge(),

        // Add other routes as needed
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
