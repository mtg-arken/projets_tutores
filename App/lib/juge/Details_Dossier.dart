import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
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
  bool showProblemInputs = false; // Track whether to show the problem inputs
  TextEditingController dateController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  bool visiteChecked = false;
  bool temoignageChecked = false;
  TextEditingController lieuController =
      TextEditingController(); // New controller for lieu

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
      appBar: AppBar(
        title: Text('Details dossier'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Add the logout logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Ref: ${widget.refs}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            // Replace ListView.builder with Column and children
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < data.length; index++)
                  _buildListItem(index),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add your validation logic here
                // This will be executed when the "Validate" button is pressed
              },
              child: Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    String key = data.keys.elementAt(index);
    String? value = '';

    if (key == 'Problem') {
      value = data[key] == 'false' ? 'pas de probleme' : 'probleme';

      if (data[key] == 'false') {
        // If problem is false, show checkbox
        return Column(
          children: [
            CheckboxListTile(
              title: Text('No Problem'),
              value: showProblemInputs,
              onChanged: (value) {
                setState(() {
                  showProblemInputs = value!;
                });
              },
            ),
            if (showProblemInputs)
              Column(
                children: [
                  Text('Type of Problem:'),
                  CheckboxListTile(
                    title: Text('Visite'),
                    value: visiteChecked,
                    onChanged: (value) {
                      setState(() {
                        visiteChecked = value!;
                        if (value) {
                          temoignageChecked = false;
                        }
                      });
                    },
                  ),
                  if (visiteChecked)
                    TextFormField(
                      controller: lieuController,
                      decoration: InputDecoration(labelText: 'Lieu'),
                    ),
                  CheckboxListTile(
                    title: Text('Temoignage'),
                    value: temoignageChecked,
                    onChanged: (value) {
                      setState(() {
                        temoignageChecked = value!;
                        if (value) {
                          visiteChecked = false;
                        }
                      });
                    },
                  ),
                  DateTimeField(
                    format: format,
                    controller: dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (date != null) {
                        return date;
                      }
                      return currentValue;
                    },
                  ),
                ],
              ),
          ],
        );
      }
    } else if (key == 'status') {
      value = data[key] == 'false' ? 'Pas encore valider' : 'valider';
    } else {
      value = data[key];
    }

    return ListTile(
      title: Text('$key: $value'),
    );
  }
}
