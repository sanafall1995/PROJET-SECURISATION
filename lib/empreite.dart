import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pointage/Authentification.dart';
import 'package:pointage/accueille.dart'; // Assurez-vous d'importer la bonne page
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpreinteDigitale extends StatefulWidget {
  final String userId;

  EmpreinteDigitale({required this.userId});

  @override
  State<EmpreinteDigitale> createState() => EmpreinteDigitaleState();
}

class Authentication {
  static final _authen = LocalAuthentication();

  static Future<bool> canAuthenticate() async =>
      await _authen.canCheckBiometrics || await _authen.isDeviceSupported();

  static Future<bool> authentication() async {
    try {
      if (!await canAuthenticate()) return false;
      return await _authen.authenticate(
          localizedReason: "ENTRE DANS L'APPLICATION");
    } catch (e) {
      print('Error during authentication: $e');
      return false;
    }
  }

  static Future<bool> registerFingerprint() async {
    try {
      if (!await canAuthenticate()) return false;

      List<BiometricType> availableBiometrics =
          await _authen.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        bool registered = await _authen.authenticate(
          localizedReason: "TOUCHEZ VOTRE EMPREINTE POUR L'ENREGISTREMENT",
        );
        return registered;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during fingerprint registration: $e');
      return false;
    }
  }
}

class EmpreinteDigitaleState extends State<EmpreinteDigitale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            bool registered = await Authentication.registerFingerprint();
            if (registered) {
              await saveFingerprintIdToFirestore(widget.userId);
              print("Fingerprint registration status: $registered");
            } else {
              print("Fingerprint registration failed.");
            }
          },
          icon: Icon(Icons.fingerprint),
          label: Text("ENREGISTRER EMPREINTE"),
        ),
      ),
    );
  }

  Future<void> saveFingerprintIdToFirestore(String userId) async {
    CollectionReference empreintesCollection =
        FirebaseFirestore.instance.collection('empreintes');

    await empreintesCollection.add({
      'userId': userId,
    });

    print('Empreinte enregistrée avec succès dans Firestore.');
  }
}
