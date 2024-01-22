import 'package:flutter/material.dart';
import 'package:tribunal/President_Jury/detailesDossiePre.dart';
import '../Common_Pages/common_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListDossierNonValider extends StatefulWidget {
  @override
  _ListDossierNonValiderState createState() => _ListDossierNonValiderState();
}

class _ListDossierNonValiderState extends State<ListDossierNonValider> {
  List<Map<String, dynamic>> dossiers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/dossier/GetPresidentDossiers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"PresidentId": '65a64f738853c577e0137fc9'}),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: $responseData');

        setState(() {
          dossiers = responseData;
        });
      } else {
        throw Exception('Failed to load dossier details');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'List des dossiers non valides',
        onLogout: () {
          // Add the logout logic here
        },
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Liste des dossiers non valides',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: MyTable(
                      data: dossiers,
                      onRowTap: (dossier) => handleRowTap(context, dossier),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void handleRowTap(BuildContext context, Map<String, dynamic> dossier) {
    String ref = dossier['Ref'] ?? '';
    print('Row tapped - Ref: $ref');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsDossierPre(ref: ref),
      ),
    );
  }
}

class MyTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(Map<String, dynamic>)? onRowTap;

  MyTable({required this.data, this.onRowTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        columns: [
          DataColumn(
            label: SizedBox(
              width: 50.0,
              child: Center(
                child: Text('Ref'),
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: SizedBox(
              width: 50.0,
              child: Center(
                child: Text('Problem'),
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: SizedBox(
              width: 150.0,
              child: Center(
                child: Text('Status'),
              ),
            ),
            numeric: true,
          ),
        ],
        rows: data.map((dossier) {
          return DataRow(
            cells: [
              DataCell(
                Center(
                  child: Text(dossier['Ref'] ?? ''),
                ),
              ),
               DataCell(
                Center(
                  child: Text(dossier['Problem'] != null
                      ? dossier['Problem']
                      : 'Pas de problème'),
                ),
              ),
              DataCell(
                Center(
                  child: dossier['status']
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(Icons.close, color: Colors.red),
                ),
              ),
            ],
            onSelectChanged: (isSelected) {
              if (isSelected != null && isSelected) {
                if (onRowTap != null) {
                  onRowTap!(dossier);
                }
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
