import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class ListJuge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Liste des juges',
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
                'Liste des Juges',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(
                      255, 5, 43, 75), // Color for the title text
                ),
              ),
            ),
            // DataTable
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: DataTable(
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      columns: [
                        DataColumn(label: Text('Nom')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Téléphone')),
                        DataColumn(
                          label: Text('Nombre de Dossier'),
                          numeric: true,
                        ),
                      ],
                      rows: [
                        _buildDataRow(
                            'Juge 1', 'juge1@g.com', '123456789', '5'),
                        _buildDataRow(
                            'Juge 2', 'juge2@g.com', '987654321', '8'),
                        _buildDataRow(
                            'Juge 3', 'juge3@g.com', '555555555', '12'),
                        _buildDataRow(
                            'Juge 4', 'juge4@g.com', '111111111', '3'),
                        _buildDataRow(
                            'Juge 5', 'juge5@g.com', '999999999', '15'),
                        _buildDataRow(
                            'Juge 6', 'juge6@g.com', '777777777', '9'),
                        _buildDataRow(
                            'Juge 7', 'juge7@g.com', '444444444', '10'),
                        _buildDataRow(
                            'Juge 4', 'juge4@g.com', '111111111', '11'),
                        _buildDataRow(
                            'Juge 5', 'juge5@g.com', '999999999', '12'),
                        _buildDataRow(
                            'Juge 6', 'juge6@g.com', '777777777', '13'),
                        _buildDataRow(
                            'Juge 7', 'juge7@g.com', '444444444', '14'),
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
      String nom, String email, String phone, String numberOfDossiers) {
    return DataRow(cells: [
      DataCell(Text(nom)),
      DataCell(Text(email)),
      DataCell(Text(phone)),
      DataCell(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(numberOfDossiers),
        ),
      ),
    ]);
  }
}
