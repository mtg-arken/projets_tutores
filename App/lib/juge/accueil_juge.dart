import 'package:flutter/material.dart';
import 'package:tribunal/juge/Details_Dossier.dart';
import '../Common_Pages/common_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccueilJuge extends StatefulWidget {
  @override
  _AccueilJugeState createState() => _AccueilJugeState();
}

class _AccueilJugeState extends State<AccueilJuge> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/dossier/GetJudgeDossiers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"JudgeId": '65a64f5f8853c577e0137fc6'}),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> responseData =
            (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: $responseData');

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

  void handleRowTap(DataRow row) {
    String refs = '';
    String description = '';

    if (row.cells[0].child is Center &&
        (row.cells[0].child as Center).child is Text) {
      refs = ((row.cells[0].child as Center).child as Text).data ?? '';
    }

    if (row.cells[1].child is Center &&
        (row.cells[1].child as Center).child is Text) {
      description =
          ((row.cells[1].child as Center).child as Text).data ?? '';
    }

    print('Row tapped - Refs: $refs, Description: $description');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsDossier(refs: refs),
      ),
    );
  }

  void handleLogout() {
    // Add your logout logic here, such as clearing user session, navigating to login screen, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Juge',
        onLogout: handleLogout, // Updated to use the handleLogout function
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Liste des dossiers',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: MyTable(data: data, onRowTap: handleRowTap),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final Function(DataRow)? onRowTap;

  MyTable({required this.data, this.onRowTap});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: false,
      columns: [
        DataColumn(
          label: SizedBox(
            width: 50.0,
            child: Center(
              child: Text('Refs'),
            ),
          ),
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
      rows: data.map((item) {
        return DataRow(
          cells: [
            DataCell(
              Center(
                child: Text(item['Refs'] ?? ''), // Update to match your data structure
              ),
            ),
            DataCell(
              Center(
                child: Text(item['Description'] ?? ''), // Update to match your data structure
              ),
            ),
          ],
          onSelectChanged: (isSelected) {
            if (isSelected != null && isSelected) {
              if (onRowTap != null) {
                onRowTap!(DataRow(cells: [
                  DataCell(
                    Center(
                      child: Text(item['Refs'] ?? ''), // Update to match your data structure
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(item['Description'] ?? ''), // Update to match your data structure
                    ),
                  ),
                ]));
              }
            }
          },
        );
      }).toList(),
    );
  }
}

