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
        padding:
            EdgeInsets.only(top: 20.0), // Ajustez le padding selon vos besoins
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 images par ligne
                crossAxisSpacing: 8.0, // Espace horizontal entre les images
                mainAxisSpacing: 8.0, // Espace vertical entre les lignes
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LogoButton(
                        imagePath: getImagePath(index),
                        onPressed: () {
                          // Action à effectuer lors du clic sur le bouton logo
                          print('Bouton Logo $index cliqué');
                          // Ajoutez ici les actions spécifiques au bouton logo
                        },
                      ),
                      Text(
                        getLabelText(index),
                        style: TextStyle(fontSize: 21.0),
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

  // Fonction pour obtenir le chemin de l'image en fonction de l'index
  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/listeDossiers.png';
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

  // Fonction pour obtenir le texte en fonction de l'index
  String getLabelText(int index) {
    switch (index) {
      case 0:
        return 'liste des Dossiers ';
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
        height: 100.0, // Ajustez la hauteur selon vos besoins
      ),
    );
  }
}
