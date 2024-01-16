import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatelessWidget {
  void _login(BuildContext context) async {
    String cin = _cinValue.text;
    String password = _passwordValue.text;

    print('CIN: $cin, Password: $password');
    try {
      // Make the API call
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/Login'),
        body: jsonEncode({
          'Cin': cin,
          'Password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode== 201) {
        var responseData = jsonDecode(response.body);
        print('API Response: $responseData');
        print( responseData['user']['role']);
        if(responseData['user']['role']=='jury'){
          Navigator.pushReplacementNamed(context, '/juge');
        }
        else{
           Navigator.pushReplacementNamed(context, '/president');
        }
        
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  final TextEditingController _cinValue = TextEditingController();
  final TextEditingController _passwordValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/judge_icon.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Authentification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _cinValue,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Numero carte CIN',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordValue,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _login(context), // Call the _login function
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                    ),
                    child: Text(
                      "S'authentifier",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
