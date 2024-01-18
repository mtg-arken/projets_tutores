import 'package:flutter/material.dart';
import 'Common_Pages/login_Page.dart';

import 'juge/accueil_juge.dart';
import 'juge/Details_Dossier.dart';

import 'President_Jury/accueil_president.dart';
import 'President_Jury/Create_Dossier.dart';
import 'President_Jury/List_Dossiers_Non_Validers.dart';
import 'President_Jury/List_Dossiers_Validers.dart';
import 'President_Jury/List_Juges.dart';
import 'President_Jury/detailesDossiePre.dart';

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
      initialRoute: '/ListDossierValider',
      routes: {
        '/login': (context) => LoginPage(),
        '/president': (context) => AccueilPresident(),
        '/CreateDossier': (context) => CreateDossier(),
        '/ListDossierValider': (context) => ListDossierValider(),
        '/ListDossierNonValider': (context) => ListDossierNonValider(),
        '/ListJuge': (context) => ListJuge(),
        '/juge': (context) => AccueilJuge(),
        '/DtailsDossier': (context) => DetailsDossier(refs: ''),
        '/DetailsDossierPre': (context) => DetailsDossierPre(
              data: {},
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
