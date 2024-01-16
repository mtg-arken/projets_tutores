import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListDossierNonValider extends StatefulWidget {
  @override
  _ListDossierNonValiderState createState() => _ListDossierNonValiderState();
}

class _ListDossierNonValiderState extends State<ListDossierNonValider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'ListDossierNonValider',
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
