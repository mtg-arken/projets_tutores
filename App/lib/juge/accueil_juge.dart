import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class AccueilJuge extends StatefulWidget {
  @override
  _AccueilJugeState createState() => _AccueilJugeState();
}

class _AccueilJugeState extends State<AccueilJuge> {
  List<Map<String, String>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace the API call with your actual API endpoint and logic
    // For example purposes, we're using a dummy API call here
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      data = [
        {'refs': 'Ref1', 'description': 'Description 1'},
        {'refs': 'Ref2', 'description': 'Description 2'},
        {'refs': 'Ref3', 'description': 'Description 3'},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Juge',
        onLogout: () {
          // Ajouter la logique de déconnexion ici
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title at the top
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Liste des dossier ',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Your Table
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: MyTable(data: data),
            ),
          ],
        ),
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
        DataColumn(
          label: SizedBox(
              width: 50.0,
              child: Center(
                child: Text('Refs'),
              )),
          numeric: true,
        ),
        DataColumn(
          label: SizedBox(
            width: 150.0,
            child: Center(
              child: Text('Description'),
            ),
          ),
          numeric: true,
        ),
      ],
      rows: List<DataRow>.generate(
        data.length,
        (index) => DataRow(
          cells: [
            DataCell(
              Center(
                child: Text(data[index]['refs'] ?? ''),
              ),
            ),
            DataCell(
              Center(
                child: Text(data[index]['description'] ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
