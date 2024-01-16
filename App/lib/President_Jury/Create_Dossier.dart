import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class CreateDossier extends StatefulWidget {
  @override
  _CreateDossierState createState() => _CreateDossierState();
}

class _CreateDossierState extends State<CreateDossier> {
  final _formKey = GlobalKey<FormState>();
  String? selectedJuge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Président',
        onLogout: () {},
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 221, 224), // Background color
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0, // Shadow for a card-like appearance
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
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

                      // Description input field
                      TextFormField(
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

                      // Dropdown to select a judge
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedJuge,
                          onChanged: (String? newValue) {
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
                      ),
                      SizedBox(height: 32.0),

                      // Buttons to validate or cancel
                      // Buttons to validate or cancel
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center buttons horizontally
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.green, // Change the background color
                              onPrimary: Colors.white, // Change the text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16), // Add padding
                            ),
                            child: Text('Valider'),
                          ),
                          SizedBox(width: 16.0), // Add space between buttons
                          ElevatedButton(
                            onPressed: () {
                              _resetForm();
                            },
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Colors.red, // Change the background color
                              onPrimary: Colors.white, // Change the text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16), // Add padding
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

// Fonction pour créer les éléments de la liste déroulante des juges
  List<DropdownMenuItem<String>> _buildJugeDropdownItems() {
    return [
      'Juge 1',
      'Juge 2',
      'Juge 3',
      // Ajoutez d'autres juges au besoin
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

// Fonction pour soumettre le formulaire
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Traitement en cours')),
      );
    }
  }

// Fonction pour réinitialiser le formulaire
  void _resetForm() {
    _formKey.currentState!.reset();
  }
}
