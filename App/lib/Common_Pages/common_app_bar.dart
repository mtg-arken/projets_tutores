import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  const CommonAppBar({required this.title, required this.onLogout});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 5, 43, 75),
              ),
              child: Text(
                'Tribunal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Accueil'),
              onTap: () {
                // Ajoutez ici les actions spécifiques à la page d'accueil
                print('Accueil sélectionné');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Compte'),
              onTap: () {
                // Ajoutez ici les actions spécifiques à la page du compte
                print('Compte sélectionné');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Contenu de la page'),
        // Ajoutez ici le contenu de la page
      ),
    );
  }
}
