import 'package:flutter/material.dart';
import 'package:tribunal/President_Jury/detailesDossiePre.dart';
import '../Common_Pages/common_app_bar.dart';

class ListDossierValider extends StatefulWidget {
  @override
  _ListDossierValiderState createState() => _ListDossierValiderState();
}

class _ListDossierValiderState extends State<ListDossierValider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Dossiers Validés',
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
                'Liste des dossiers validés',
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
                        _buildDataRow(
                          '1',
                          'Juge1',
                          '',
                          'Dossier sans problème résolu',
                          context,
                        ), // No problem, green check, and resolved
                        _buildDataRow(
                          '2',
                          'Juge2',
                          'Problème',
                          'Dossier avec problème résolu',
                          context,
                        ), // Problem, red cross, and resolved
                        _buildDataRow(
                          '3',
                          'Juge3',
                          'Problème',
                          'Dossier avec problème résolu',
                          context,
                        ), // Problem, red cross, and resolved
                        _buildDataRow(
                          '4',
                          'Juge4',
                          '',
                          'Dossier sans problème résolu',
                          context,
                        ), // No problem, green check, and resolved
                        _buildDataRow(
                          '5',
                          'Juge5',
                          'Problème',
                          'Dossier avec problème résolu',
                          context,
                        ), // Problem, red cross, and resolved
                        // Ajouter un exemple avec problème résolu
                        _buildDataRow(
                          '6',
                          'Juge6',
                          'Problème',
                          'Dossier avec problème résolu',
                          context,
                        ), // Problem, red cross, and resolved
                        // Ajoutez d'autres lignes de données validées ici
                        _buildDataRow(
                          '7',
                          'Juge7',
                          '',
                          'Dossier sans problème résolu',
                          context,
                        ),
                        _buildDataRow(
                          '8',
                          'Juge8',
                          '',
                          'Dossier sans problème résolu',
                          context,
                        ),
                        _buildDataRow(
                          '9',
                          'Juge9',
                          '',
                          'Dossier sans problème résolu',
                          context,
                        ),
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
    BuildContext context,
  ) {
    bool hasProblem = probleme.isNotEmpty;

    return DataRow(
      cells: [
        DataCell(Text(reference)),
        DataCell(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsDossierPre(
                    data: {},
                  ),
                ),
              );
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
                ? Text('Résolu') // Toujours considérer le problème comme résolu
                : Container(),
          ),
        ),
      ],
    );
  }
}
