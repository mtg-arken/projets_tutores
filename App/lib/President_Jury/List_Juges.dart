import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListJuge extends StatefulWidget {
  @override
  _ListJugeState createState() => _ListJugeState();
}

class _ListJugeState extends State<ListJuge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'ListJuge',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
      body: Container(
          // Vous pouvez personnaliser le conteneur si nécessaire
          ),
    );
  }
}
