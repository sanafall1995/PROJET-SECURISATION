import 'package:flutter/material.dart';

class MiseAjour extends StatefulWidget {
  const MiseAjour({super.key});

  @override
  State<MiseAjour> createState() => _MiseAjourState();
}

class _MiseAjourState extends State<MiseAjour> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("BIENVENUE DANS LA PAGE DE MISE A JOUR"),
      ),
    );
  }
}
