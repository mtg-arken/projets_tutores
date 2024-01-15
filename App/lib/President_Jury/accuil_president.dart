// judge_login.dart

import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class JudgeLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Judge Login',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
    );
  }
}
