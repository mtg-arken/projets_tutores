import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListDossierValider extends StatelessWidget {
  // Sample data
  final List<Map<String, dynamic>> dossiers = [
    {'ref': 'n1', 'problem': 'visite', 'status': true},
    {'ref': 'n2', 'problem': 'tem', 'status': false},
    {'ref': 'n3', 'problem': 'visite', 'status': true},
    {'ref': 'n4', 'problem': 'tem', 'status': false},
    {'ref': 'n5', 'problem': 'visite', 'status': true},
    {'ref': 'n6', 'problem': 'tem', 'status': false},
    {'ref': 'n7', 'problem': 'visite', 'status': true},
    {'ref': 'n8', 'problem': 'tem', 'status': false},
    {'ref': 'n9', 'problem': 'visite', 'status': true},
    {'ref': 'n10', 'problem': 'tem', 'status': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'List des dossiers non valides',
        onLogout: () {
          // Add the logout logic here
        },
      ),
      body: SingleChildScrollView(
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
                child: MyTable(data: dossiers, onRowTap: handleRowTap),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleRowTap(Map<String, dynamic> dossier) {
    String ref = dossier['ref'];
    print('Row tapped - Ref: $ref');
/*
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsDossierPre(data: dossier),
      ),
    );*/
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
              width: 150.0,
              child: Center(
                child: Text('Problem'),
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: SizedBox(
              width: 100.0,
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
                  child: Text(dossier['ref'] ?? ''),
                ),
              ),
              DataCell(
                Center(
                  child: Text(dossier['problem'] ?? ''),
                ),
              ),
              DataCell(
                Center(
                  child: Text(dossier['status'].toString() ),
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
