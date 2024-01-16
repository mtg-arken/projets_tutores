import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;
  final bool showBackButton; // Ajout de la condition

  const CommonAppBar({
    required this.title,
    required this.onLogout,
    this.showBackButton = true, // Initialisation de la condition
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 5, 43, 75),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: onLogout,
        ),
      ],
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Retour à la page AccueilPresident
                Navigator.pop(context);
              },
            )
          : null, // Utilisation de null pour masquer le bouton si showBackButton est faux
    );
  }
}
