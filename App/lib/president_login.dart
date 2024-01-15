import 'package:flutter/material.dart';

class PresidentLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('President Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/president_icon.png',
              ), // Assurez-vous de mettre votre image dans le dossier 'assets'
              radius: 50,
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ajoutez votre logique de connexion pour le président ici
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Ajoutez votre logique pour la récupération de mot de passe ici
              },
              child: Text('Mot de passe oublié ?'),
            ),
          ],
        ),
      ),
    );
  }
}
