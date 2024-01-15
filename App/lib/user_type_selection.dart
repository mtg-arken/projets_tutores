/*import 'package:flutter/material.dart';
import 'Common_Pages/Login_Page.dart' as judge;
import 'president_login.dart' as president;

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User Type'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLoginButton(context, 'Judge Login', judge.LoginPage()),
              SizedBox(height: 20),
              _buildLoginButton(
                  context, 'President Login', president.PresidentLoginPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(text),
    );
  }
}
*/