import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsDossier extends StatefulWidget {
  final String refs;

  DetailsDossier({required this.refs});

  @override
  _DetailsDossierState createState() => _DetailsDossierState();
}

class _DetailsDossierState extends State<DetailsDossier> {
  Map<String, String> data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String ref = widget.refs;
    Map<String, dynamic>? responseData;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/dossier/GetDossierByRef'),
        body: jsonEncode({
          'Ref': ref,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        print('Dossier object: $responseData');
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }

    if (responseData != null) {
      Map<String, String> stringData = {};
      responseData.forEach((key, value) {
        stringData[key] = value.toString();
      });
      setState(() {
        data = stringData;
      });
      print('aaaa: $data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      appBar: AppBar(
        title: Text('Détailes Dossier'),
      ),
      body: Container(
          // You can customize the container if needed
          ),
=======
      appBar: CommonAppBar(
        title: 'Details dossier',
        onLogout: () {
          // Add the logout logic here
        },
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Ref: ${widget.refs}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                String key = data.keys.elementAt(index);
                String value = '';

                if (key == 'Problem') {
                  data[key] == 'false' ? 'pas de probleme' : 'probleme';
                } else if (key == 'status') {
                  value =
                      data[key] == 'false' ? 'Pas encore valider' : 'valider';
                } else {
                  value = data[key] ?? '';
                }

                return ListTile(
                  title: Text('$key: $value'),
                );
              },
            ),
          ],
        ),
      ),
>>>>>>> Stashed changes
    );
  }
}
