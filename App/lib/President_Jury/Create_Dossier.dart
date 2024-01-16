import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class CreateDossier extends StatefulWidget {
  @override
  _CreateDossierState createState() => _CreateDossierState();
}

class _CreateDossierState extends State<CreateDossier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'CreateDossier',
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
