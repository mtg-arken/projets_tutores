import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListDossierNonValider extends StatefulWidget {
  @override
  _ListDossierNonValiderState createState() => _ListDossierNonValiderState();
}

class _ListDossierNonValiderState extends State<ListDossierNonValider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: ' Dossiers Non Valides',
        onLogout: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue, // Underline color
                    width: 2.0, // Underline thickness
                  ),
                ),
              ),
              child: Text(
                'Liste des dossiers non valides',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(
                      255, 5, 43, 75), // Color for the title text
                ),
              ),
            ),
            // DataTable
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Color for the table border
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: DataTable(
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      columns: [
                        DataColumn(label: Text('Référence')),
                        DataColumn(label: Text('juge')),
                        DataColumn(label: Text('Problème')),
                        DataColumn(label: Text('Descréption')),
                      ],
                      rows: [
                        _buildDataRow('1', 'juge1', '', 'doss1'),
                        _buildDataRow('2', 'juge2', '', 'doss2'),
                        _buildDataRow('3', 'juge3', '', 'doss3'),
                        _buildDataRow('4', 'juge4', '', 'doss4'),
                        _buildDataRow('5', 'juge5', '', 'doss5'),
                        _buildDataRow('6', 'juge6', '', 'doss6'),
                        _buildDataRow('7', 'juge7', '', 'doss7'),
                        _buildDataRow('8', 'juge8', '', 'doss8'),
                        _buildDataRow('9', 'juge9', '', 'doss9'),
                        _buildDataRow('10', 'juge10', '', 'doss10'),
                        _buildDataRow('11', 'juge11', '', 'doss11'),
                        // Add more rows as needed
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(
      String reference, String juge, String probleme, String description) {
    return DataRow(cells: [
      DataCell(Text(reference)),
      DataCell(Text(juge)),
      DataCell(Text(probleme)),
      DataCell(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(description),
        ),
      ),
    ]);
  }
}
