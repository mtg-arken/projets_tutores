import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class CreateDossier extends StatefulWidget {
  @override
  _CreateDossierState createState() => _CreateDossierState();
}

class _CreateDossierState extends State<CreateDossier> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController referenceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Map<String, dynamic>? selectedJuge;
  DateTime? selectedDate;
  List<Map<String, dynamic>> jurys = [];
  late String userId ="65a64f738853c577e0137fc9";

  @override
  void initState() {
    super.initState();
    _initiateJurysData();
    
  }

  Future<void> _initiateJurysData() async {
    try {
      print("userid $userId");

      var response =
          await http.get(Uri.parse('http://10.0.2.2:5000/api/user/getJurys'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          jurys.clear();
          if (jsonData.isNotEmpty) {
            // Add each object from the list to jurys
            for (var item in jsonData) {
              if (item is Map<String, dynamic>) {
                jurys.add(item);
              }
            }
          }
        });
      } else {
        print(
            'Error - Status Code: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to load jurys');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Création dossiers',
        onLogout: () {},
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 221, 224),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: referenceController,
                        decoration: InputDecoration(
                          labelText: 'Référence',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir des références';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir une description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        value: selectedJuge,
                        onChanged: (Map<String, dynamic>? newValue) {
                          setState(() {
                            selectedJuge = newValue;
                          });
                        },
                        items: _buildJugeDropdownItems(),
                        decoration: InputDecoration(
                          labelText: 'Juge',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez sélectionner un juge';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'Date de l\'audience',
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              dateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        validator: (value) {
                          if (selectedDate == null) {
                            return 'Veuillez sélectionner une date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                            ),
                            child: Text('Valider'),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              _resetForm();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                            ),
                            child: Text('Annuler'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Map<String, dynamic>>> _buildJugeDropdownItems() {
    return jurys.map<DropdownMenuItem<Map<String, dynamic>>>(
        (Map<String, dynamic> user) {
      return DropdownMenuItem<Map<String, dynamic>>(
        value: user,
        child: Text(user['username'].toString()),
      );
    }).toList();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var reference = referenceController.text;
      var description = descriptionController.text;
      var jury = selectedJuge;
      var dateAudience = selectedDate;

      // Create a Map to represent the data
      var postData = {
        'reference': reference,
        'description': description,
        'jury': jury?['_id'],
        'dateAudience': dateAudience
            ?.toIso8601String(), // Assuming dateAudience is DateTime
        'president': userId
      };

      print('d: $postData');

      try {
        // Make a POST request
        var response = await http.post(
          Uri.parse(
              'http://10.0.2.2:5000/api/dossier/CreateDossier'), // Replace with your API URL
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(postData),
        );

        if (response.statusCode == 200) {
          // Handle success, e.g., show a success message
            Navigator.pushReplacementNamed(context, '/president');
        } else {
          // Handle error, e.g., show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors du traitement')),
          );
          print(
              'Error - Status Code: ${response.statusCode}, Body: ${response.body}');
        }
      } catch (error) {
        // Handle network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du traitement')),
        );
        print('Error: $error');
      }
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    referenceController.clear();
    descriptionController.clear();
    dateController.clear();
    selectedJuge = null;
    selectedDate = null;
  }
}
