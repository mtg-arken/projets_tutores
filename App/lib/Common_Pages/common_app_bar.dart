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
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Ajoutez ici les actions spécifiques à l'élément 1 du tiroir
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Ajoutez ici les actions spécifiques à l'élément 2 du tiroir
              },
            ),
            // ... Ajoutez d'autres éléments du tiroir au besoin
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
