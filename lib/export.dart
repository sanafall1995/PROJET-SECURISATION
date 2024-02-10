import 'package:flutter/material.dart';

class Export extends StatefulWidget {
  const Export({super.key});

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("BIENVENUE DANS LA PAGE D'EXPORT"),
      ),
    );
  }
}
