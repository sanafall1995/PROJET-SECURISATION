import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListeAgent extends StatefulWidget {
  @override
  _ListeAgentState createState() => _ListeAgentState();
}

class _ListeAgentState extends State<ListeAgent> {
  final CollectionReference employesCollection =
      FirebaseFirestore.instance.collection('employes');
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Container(
          height: 40,
          width: 210,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Rechercher.....',
              hintStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                // Utiliser OutlineInputBorder pour ajouter une bordure
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                    10.0), // Spécifier le rayon de la bordure
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 174, 228, 245),
            ),
            cursorColor: Colors.white,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            onTap: () {
              // Gérer l'action de clic sur le champ de texte
            },
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: employesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'),
            );
          }

          // Les données sont prêtes
          List<DocumentSnapshot> employes = snapshot.data!.docs;
          List<DocumentSnapshot> filteredEmployes = employes
              .where((employe) => employe['matricule']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredEmployes.length,
            itemBuilder: (context, index) {
              if (index >= 0 && index < filteredEmployes.length) {
                var employe =
                    filteredEmployes[index].data() as Map<String, dynamic>;
                var matricule = employe['matricule'];

                String prenom = filteredEmployes[index].get('prenom');
                String nom = filteredEmployes[index].get('nom');
                String adresse = filteredEmployes[index].get('adresse');
                String poste = filteredEmployes[index].get('poste');

                // Afficher les données dans un widget ListTile par exemple
                return ListTile(
                  title: Text('$prenom $nom'),
                  subtitle: Text(
                      'Adresse: $adresse\nMatricule: $matricule\nPoste: $poste'),
                  // Vous pouvez personnaliser la présentation comme vous le souhaitez
                );
              } else {
                return Container();
              }
              // Extraire les données nécessaires
            },
          );
        },
      ),
    );
  }
}
