import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsDossier extends StatefulWidget {
  final String refs;

  DetailsDossier({required this.refs});

  @override
  _DetailsDossierState createState() => _DetailsDossierState();
}

class _DetailsDossierState extends State<DetailsDossier> {
  Map<String, dynamic> data = {};

  bool showProblemInputs = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController lieuController = TextEditingController();
  TextEditingController negotiationDescriptionController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  bool problemChecked = false;
  bool visiteChecked = false;
  bool temoignageChecked = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/dossier/GetDossierByRef'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"Ref": widget.refs}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response from API: $responseData');

        setState(() {
          data = responseData;
        });
      } else {
        throw Exception('Failed to load dossier details');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> sendData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/problem/DeclareProblem'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "dossierID": widget.refs,
          "problemType": visiteChecked ? "visite" : "temoignage",
          "lieu": visiteChecked ? lieuController.text : "",
          "date_prob": dateController.text,
          "date_negotiation": data['date_negotiation'], // Include date_negotiation in the request
          "description": negotiationDescriptionController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., show a success message
        print('Data sent successfully');
        Navigator.pushNamed(context, '/juge');
      } else {
        // Handle failure, e.g., show an error message
        print('Failed to send data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


 Future<void> sendDescription() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/problem/DeclareProblem'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "dossierID": widget.refs,
          "problemType": visiteChecked ? "visite" : "temoignage",
          "lieu": visiteChecked ? lieuController.text : "",
          "date_prob": dateController.text,
          "date_negotiation": data['date_negotiation'], // Include date_negotiation in the request
          "description": negotiationDescriptionController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., show a success message
        print('Data sent successfully');
        Navigator.pushNamed(context, '/juge');
      } else {
        // Handle failure, e.g., show an error message
        print('Failed to send data');
      }
    } catch (error) {
      print('Error: $error');
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
              // Add your logout logic here
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
            Text('President Chambre: ${data['President_Chambre']}'),
            Text('Juge: ${data['Juge']}'),
            if (data['Problem'] == true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('type de Problem: ${data['problemType']}'),
                  if (data['lieu'] != null && data['lieu'] is String)
                    Text('lieu: ${data['lieu']}'),
                  Text('Date du problem: ${data['date_Prob']}'),
                  if (data['date_negotiation'] != null)
                    Column(
                      children: [
                        Text('Date du negotiation: ${data['date_negotiation']}'),
                        // Input for negotiation description
                        TextFormField(
                          controller: negotiationDescriptionController,
                          decoration: InputDecoration(labelText: 'Description de la négociation'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            sendDescription();
                          },
                          child: Text('Validate'),
                        ),
                      ],
                    ),
                  if (data['date_negotiation'] == null)
                    Text('Date du negotiation: Pas encore'),
                ],
              ),
            if (data['Problem'] == false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Problem: Pas de problem'),
                      Checkbox(
                        value: problemChecked,
                        onChanged: (value) {
                          setState(() {
                            problemChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  if (problemChecked)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type de problem:'),
                        Row(
                          children: [
                            Text('Visite'),
                            Checkbox(
                              value: visiteChecked,
                              onChanged: (value) {
                                setState(() {
                                  visiteChecked = value ?? false;
                                  if (visiteChecked) {
                                    temoignageChecked = false;
                                  }
                                });
                              },
                            ),
                            Text('Temoignage'),
                            Checkbox(
                              value: temoignageChecked,
                              onChanged: (value) {
                                setState(() {
                                  temoignageChecked = value ?? false;
                                  if (temoignageChecked) {
                                    visiteChecked = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        if (visiteChecked)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.0),
                              Text('Lieu:'),
                              TextFormField(
                                controller: lieuController,
                                decoration: InputDecoration(
                                  hintText: 'Enter lieu',
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 10.0),
                        Text('Date:'),
                        DateTimeField(
                          controller: dateController,
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            return date;
                          },
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            sendData();
                          },
                          child: Text('Validate'),
                        ),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
