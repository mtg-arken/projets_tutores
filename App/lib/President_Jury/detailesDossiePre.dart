import 'package:flutter/material.dart';
import '../Common_Pages/common_app_bar.dart';

class DetailsDossierPre extends StatefulWidget {
  final Map<String, String> data;

  const DetailsDossierPre({Key? key, required this.data}) : super(key: key);

  @override
  _DetailsDossierPreState createState() => _DetailsDossierPreState();
}

class _DetailsDossierPreState extends State<DetailsDossierPre> {
  @override
  Widget build(BuildContext context) {
    // Check if 'probleme' is true
    bool hasProblem = widget.data['probleme'] == 'True';

    // Check if 'type de probleme' is 'résolu'
    bool problemResolved = widget.data['type de probleme'] == 'résolu';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre en gras
            Text(
              'Détails du Dossier',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),

            // Ligne de référence
            _buildDetailRow('Référence', widget.data['reference'] ?? ''),

            // Afficher les détails spécifiques si 'probleme' est true
            if (hasProblem) ...[
              _buildDetailRow('Problème', 'True'),
              _buildDetailRow(
                  'État Problème', widget.data['etat probleme'] ?? ''),
              _buildDetailRow(
                  'Type de Problème', widget.data['type de probleme'] ?? ''),
              _buildDetailRow('Lieu', widget.data['lieu'] ?? ''),
              _buildDetailRow('Date', widget.data['date'] ?? ''),
            ],

            // Afficher un bouton si 'type de probleme' est 'résolu'
            if (problemResolved) ...[
              ElevatedButton(
                onPressed: () {
                  // Ajoutez l'action que vous souhaitez effectuer ici
                },
                child: Text('Bouton Date Négociation'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label en gras
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.0),
          // Valeur
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
