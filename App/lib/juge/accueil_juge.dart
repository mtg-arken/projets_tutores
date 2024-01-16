import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class AccueilJuge extends StatelessWidget {
  final List<Map<String, String>> data = [
    {'refs': 'Ref1', 'description': 'Description 1'},
    {'refs': 'Ref2', 'description': 'Description 2'},
    {'refs': 'Ref3', 'description': 'Description 3'},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'President Login',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: MyTable(data: data),
      ),
    );
  }
}

class MyTable extends StatelessWidget {
  final List<Map<String, String>> data;

  MyTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Refs')),
        DataColumn(label: Text('Description')),
      ],
      rows: List<DataRow>.generate(
        data.length,
        (index) => DataRow(
          cells: [
            DataCell(Text(data[index]['refs'] ?? '')),
            DataCell(Text(data[index]['description'] ?? '')),
          ],
        ),
      ),
    );
  }
}
