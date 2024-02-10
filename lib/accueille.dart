import 'package:flutter/material.dart';
import 'package:pointage/tableauBord.dart';

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KSERVGROUP',
        ),
        backgroundColor: Color.fromARGB(255, 100, 113, 226),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/image2.jpg'), // Remplacez 'background.jpg' par votre nom de fichier d'arrière-plan
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Avec l\'assiduité comme guide et la responsabilité comme boussole, aucun objectif n\'est hors de portée',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/image1.jpg'),
              ),
              SizedBox(height: 20),
              Container(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Ajustez ce chiffre selon le degré de l'arrondi que vous souhaitez
                    child: Image.asset(
                      'assets/image.jpg', // Chemin vers votre image additionnelle
                      width:
                          200, // Largeur de l'image à l'intérieur du conteneur
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MesDossierPage()),
                  );
                },
                child: Text('ACCEDEZ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
