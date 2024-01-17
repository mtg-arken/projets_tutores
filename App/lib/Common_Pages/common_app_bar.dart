import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  const CommonAppBar({
    required this.title,
    required this.onLogout,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name ?? "";

    // Check if the current route is neither "/president" nor "/juge"
    bool shouldShowBackButton =
        currentRoute != "/president" && currentRoute != "/juge";

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
      leading: shouldShowBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
            )
          : null,
    );
  }
}
