import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DetailsDossier extends StatefulWidget {
  final String refs;

  DetailsDossier({required this.refs});

  @override
  _DetailsDossierState createState() => _DetailsDossierState();
}

class _DetailsDossierState extends State<DetailsDossier> {
  Map<String, String> data = {
    'President_Chambre': 'arken',
    'Juge': 'loufa',
    'Problem': 'false',
    'type de problem': 'visite',
    'lieu': 'monastir',
    'date problem': '2024-01-17 03-14-12',
    'date_negotiation': '2024-01-18 09-30-00',
  };

  bool showProblemInputs = false;
  TextEditingController dateController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  bool visiteChecked = false;
  bool temoignageChecked = false;
  TextEditingController lieuController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    } else if (key == 'date_negotiation') {
      value = data[key];
      return Column(
        children: [
          ListTile(
            title: Text('$key: $value'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            // Add controller or handling logic as needed
          ),
        ],
      );
    } else {
      value = data[key];
      return ListTile(
        title: Text('$key: $value'),
      );
    }

/*
  if (key == 'date_negotiation') {
    // If key is date_negotiation, add an input for description only once
    return Column(
      children: [
        ListTile(
          title: Text('$key: $value'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Description'),
          // Add controller or handling logic as needed
        ),
      ],
    );
  }

  if (data['Problem'] == 'true') {
    // If problem is true, check for date_negotiation
    bool hasDateNegotiation = data.containsKey('date_negotiation');
    return Column(
      children: [
        ListTile(
          title: Text('$key: $value'),
        ),
        if (hasDateNegotiation)
          ListTile(
            title: Text('Date Negotiation: ${data['date_negotiation']}'),
          ),
        if (hasDateNegotiation)
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            // Add controller or handling logic as needed
          ),
        if (!hasDateNegotiation)
          ListTile(
            title: Text('Date Negotiation: Pas encore'),
          ),
      ],
    );
  }
*/
    return ListTile(
      title: Text('$key: $value'),
    );
  }
}
