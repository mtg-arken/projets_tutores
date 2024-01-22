import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../Common_Pages/common_app_bar.dart';

class DetailsDossierPre extends StatefulWidget {
  final String ref;
  const DetailsDossierPre({Key? key, required this.ref}) : super(key: key);

  @override
  _DetailsDossierPreState createState() => _DetailsDossierPreState();
}

class _DetailsDossierPreState extends State<DetailsDossierPre> {
  Map<String, dynamic> dossierDetails = {};

  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Page showing with ref: ${widget.ref}");

    // Call the fetchData method in initState to initialize the Future
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/dossier/GetDossierByRef'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Ref': widget.ref}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> zz = jsonDecode(response.body);
        print('aaaaaaaaaaaaaa: $zz');

        setState(() {
          dossierDetails = jsonDecode(response.body);
        });
        print("xxxxxxxxxxxx: $dossierDetails");
      } else {
        throw Exception('Failed to load dossier details');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> postData(String reference, String date) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:5000/api/problem/AddDateNegotiation'), // Replace with your actual post endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Ref': reference, 'date_negotiation': date}),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Post request successful');
        Navigator.pushReplacementNamed(context, '/ListDossierNonValider');
      } else {
        throw Exception('Failed to send post request');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: ' Dossiers Non Valides',
        onLogout: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Détails du Dossier',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 16.0),
              _buildDetailRow('Référence', dossierDetails['reference'] ?? ''),
              _buildDetailRow(
                  'Description', dossierDetails['descriptionDossier'] ?? ''),
              _buildDetailRow('Juge', dossierDetails['Juge'] ?? ''),
              if (dossierDetails['Problem'] == true) ...[
                _buildDetailRow('type de problem', dossierDetails['problemType'] ?? ''),
                if (dossierDetails['lieu'] != null)
                  _buildDetailRow('lieu', dossierDetails['lieu']),
                _buildDetailRow('date de problem', dossierDetails['date_Prob'] ?? ''),
                if (dossierDetails['date_negotiation'] != null) ...[
                  _buildDetailRow('date negotiation', dossierDetails['date_negotiation']),
                ] else ...[
                  Text(
                    'Date Negotiation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  DateTimeField(
                    controller: _dateController,
                    format: DateFormat("yyyy-MM-dd"),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      return date;
                    },
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the button click, you can add validation and further logic here
                      String reference = dossierDetails['reference'];
                      String date = _dateController.text;
                      postData(reference, date);
                    },
                    child: Text('Valid'),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          if (value is Map) ...[
            for (var entry in value.entries)
              _buildDetailRow(entry.key, entry.value),
          ] else if (value is bool) ...[
            Text(value.toString()),
          ] else ...[
            Text('$value'),
          ],
        ],
      ),
    );
  }
}
