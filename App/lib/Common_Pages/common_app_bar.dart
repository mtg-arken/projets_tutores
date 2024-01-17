import 'package:flutter/material.dart';
import '../President_Jury/accueil_president.dart';

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

    // Modifier showBackButton en fonction du chemin actuel
    bool shouldShowBackButton = currentRoute != "/president";

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
                // if (currentRoute == "/president") {
                //   // Navigate to the home screen of the president
                //   Navigator.pushReplacementNamed(context, '/president');
                // } else {
                //   // Default behavior for other routes
                //   Navigator.pop(context);
                // }
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => AccueilPresident()));
                Navigator.pushReplacementNamed(context, '/president');
              },
            )
          : null,
    );
  }
}
