import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class AccueilPresidentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Président',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.8, // Ajustez selon vos besoins
                        child: LogoButton(
                          imagePath: getImagePath(index),
                          onPressed: () {
                            // Action à effectuer lors du clic sur le bouton logo
                            print('Bouton Logo $index cliqué');
                            // Ajoutez ici les actions spécifiques au bouton logo
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        getLabelText(index),
                        style: TextStyle(fontSize: 21.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/dossiercad.png';
      case 1:
        return 'assets/images/liste2.png';
      case 2:
        return 'assets/images/liste.png';
      case 3:
        return 'assets/images/listejuges.png';
      default:
        return '';
    }
  }

  String getLabelText(int index) {
    switch (index) {
      case 0:
        return 'créer Dossier ';
      case 1:
        return 'Dossier non traités';
      case 2:
        return 'Dossier  traités';
      case 3:
        return 'Liste des Juges';
      default:
        return '';
    }
  }
}

class LogoButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const LogoButton({required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Image.asset(
        imagePath,
        height: 100.0,
      ),
    );
  }
}
