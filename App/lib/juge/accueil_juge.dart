import 'package:flutter/material.dart';
import 'package:tribunal/juge/Details_Dossier.dart';
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
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      data = [
<<<<<<< Updated upstream
        {'refs': 'Ref1', 'description': 'Description 1'},
        {'refs': 'Ref2', 'description': 'Description 2'},
        {'refs': 'Ref3', 'description': 'Description 3'},
=======
        {'refs': 'n1', 'description': 'Description 1'},
        {'refs': 'n2', 'description': 'Description 2'},
        {'refs': 'n3', 'description': 'Description 3'},
>>>>>>> Stashed changes
      ];
    });
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
      description = ((row.cells[1].child as Center).child as Text).data ?? '';
    }

    print('Row tapped - Refs: $refs, Description: $description');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsDossier(refs: refs),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Accueil Juge',
        onLogout: () {
          // Add the logout logic here
        },
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
  final List<Map<String, String>> data;
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
          onSelectChanged: (isSelected) {
            if (isSelected != null && isSelected) {
              if (onRowTap != null) {
                onRowTap!(DataRow(cells: [
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
                ]));
              }
            }
          },
        ),
      ),
    );
  }
}
