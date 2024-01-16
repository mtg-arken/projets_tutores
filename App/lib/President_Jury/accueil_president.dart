import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class AccueilPresident extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'President Jury',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
    );
  }
}
