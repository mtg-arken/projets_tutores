import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListDossierValider extends StatefulWidget {
  @override
  _ListDossierValiderState createState() => _ListDossierValiderState();
}

class _ListDossierValiderState extends State<ListDossierValider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'ListDossierValider',
        onLogout: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
      ),
      body: Container(
          // Vous pouvez personnaliser le conteneur si nécessaire
          ),
    );
  }
}
