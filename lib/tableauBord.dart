import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointage/MiseAJour.dart';
import 'package:pointage/employe.dart';
import 'package:pointage/export.dart';
import 'package:pointage/historique.dart';
import 'package:pointage/listeAgents.dart';

class MesDossierPage extends StatefulWidget {
  const MesDossierPage({super.key});

  @override
  State<MesDossierPage> createState() => _MesDossierPageState();
}

class _MesDossierPageState extends State<MesDossierPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    "KSERV",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    "TEAM KSERVGROUP",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: Container(
                    width: 55, // Ajustez la largeur en conséquence
                    height: 60,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.black12, // Couleur bleue de la bordure
                        width: 1.0, // Épaisseur de la bordure
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset('assets/image.jpg')),
                  )),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blue,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                itemDashboard(
                    'liste des employés',
                    Icons.people,
                    const Color.fromARGB(255, 34, 49, 255),
                    () => navigateToPage(ListeAgent())),
                itemDashboard(
                  'export des données',
                  Icons.folder,
                  Colors.greenAccent,
                  () => navigateToPage(const Export()),
                ),
                itemDashboard('Historique', Icons.list, Colors.blue,
                    () => navigateToPage(const Historique())),
                itemDashboard('Mise A jour', Icons.date_range, Colors.yellow,
                    () => navigateToPage(const MiseAjour())),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Définir la couleur bleue ici
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text(
              'ENREGISTRE UN EMPOYE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  itemDashboard(String title, IconData iconData, Color background,
          VoidCallback onTap) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.blue.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      );
  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
