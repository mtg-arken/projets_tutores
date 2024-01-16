import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';
import 'List_Dossiers_Non_Validers.dart';
import 'list_Dossiers_validers.dart';
import 'list_juges.dart';
import 'Create_Dossier.dart';

class AccueilPresident extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Président',
        onLogout: () {},
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 120.0),
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
                        widthFactor: 0.8,
                        child: LogoButton(
                          imagePath: getImagePath(index),
                          onPressed: () {
                            print('Bouton Logo $index cliqué');
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        getLabelText(index),
                        style: TextStyle(
                          fontSize: 19.0,
                          color: const Color.fromARGB(255, 5, 43, 75),
                          fontWeight: FontWeight.bold,
                        ),
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
        return 'assets/images/listejuges.png';
      case 2:
        return 'assets/images/liste.png';
      case 3:
        return 'assets/images/liste2.png';
      default:
        return '';
    }
  }

  String getLabelText(int index) {
    switch (index) {
      case 0:
        return 'créer Dossier ';
      case 1:
        return 'Liste des Juges';
      case 2:
        return 'Dossier  traités';
      case 3:
        return 'Dossier non traités';
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
      onPressed: () {
        if (imagePath == 'assets/images/dossiercad.png') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateDossier()),
          );
        } else if (imagePath == 'assets/images/liste.png') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListDossierValider()),
          );
        } else if (imagePath == 'assets/images/liste2.png') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListDossierNonValider()),
          );
        } else if (imagePath == 'assets/images/listejuges.png') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListJuge()),
          );
        } else {
          onPressed();
        }
      },
      child: Image.asset(
        imagePath,
        height: 100.0,
      ),
    );
  }
}
