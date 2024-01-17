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
        onLogout: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              child: Text(
                'Liste des dossiers non valides',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 5, 43, 75),
                ),
              ),
            ),
            Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
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
                        DataColumn(label: Text('Problème')),
                        DataColumn(label: Text('Etat Prob')),
                      ],
                      rows: [
                        _buildDataRow('1', 'Juge1', '',
                            'Dossier sans problème résolu', context),
                        // No problem, green check, and resolved
                        _buildDataRow(
                            '2',
                            'Juge2',
                            'Problème',
                            'Dossier avec problème non résolu',
                            context), // Problem, red cross, and not resolved
                        _buildDataRow(
                            '3',
                            'Juge3',
                            'Problème',
                            'Dossier avec problème résolu',
                            context), // Problem, red cross, and resolved
                        _buildDataRow(
                            '4',
                            'Juge4',
                            '',
                            'Dossier sans problème résolu',
                            context), // No problem, green check, and resolved
                        _buildDataRow(
                            '5',
                            'Juge5',
                            'Problème',
                            'Dossier avec problème résolu',
                            context), // Problem, red cross, and resolved
                        _buildDataRow(
                            '6',
                            'Juge6',
                            '',
                            'Dossier sans problème résolu',
                            context), // No problem, green check, and resolved
                        _buildDataRow(
                            '7',
                            'Juge7',
                            'Problème',
                            'Dossier avec problème non résolu',
                            context), // Problem, red cross, and not resolved
                        _buildDataRow(
                            '8',
                            'Juge8',
                            '',
                            'Dossier sans problème résolu',
                            context), // No problem, green check, and resolved
                        _buildDataRow(
                            '9',
                            'Juge9',
                            'Problème',
                            'Dossier avec problème non résolu',
                            context), // Problem, red cross, and not resolved
                        _buildDataRow(
                            '10',
                            'Juge10',
                            '',
                            'Dossier sans problème résolu',
                            context), // No problem, green check, and resolved
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
    String reference,
    String juge,
    String probleme,
    String description,
    BuildContext context, // Ajout du paramètre BuildContext
  ) {
    bool hasProblem = probleme.isNotEmpty;
    bool isProblemNotResolved =
        description.toLowerCase().contains('non résolu');

    return DataRow(
      cells: [
        DataCell(Text(reference)),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/DetailsDossierPre');
            },
            child: hasProblem
                ? Icon(Icons.close, color: Colors.red)
                : Icon(Icons.check, color: Colors.green),
          ),
        ),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/DetailsDossierPre');
            },
            child: hasProblem
                ? isProblemNotResolved
                    ? Text(' non résolu')
                    : Text('Résolu')
                : Container(),
          ),
        ),
      ],
    );
  }
}
