import 'package:flutter/material.dart';
import 'login_Page.dart';

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
          onPressed: () {
            // Call the provided onLogout callback
            onLogout();

            // Navigate to the login page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(), // Replace with the actual login page
              ),
            );
          },
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
