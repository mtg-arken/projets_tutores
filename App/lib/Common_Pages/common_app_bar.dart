// common_app_bar.dart

import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  CommonAppBar({required this.title, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: onLogout,
        ),
      ],
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Ajouter la logique pour la première option du tiroir ici
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Ajouter la logique pour la deuxième option du tiroir ici
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
