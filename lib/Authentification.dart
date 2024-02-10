import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pointage/accueille.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthenticationPage(),
    );
  }
}

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage> {
  static const String localizedReason = "ENTRE DANS L'APPLICATION";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF192359),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "SE CONNECTER",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                "UTILISE TON EMPREINTE POUR SE CONNECTER!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Divider(
                color: const Color.fromARGB(153, 10, 7, 7),
              ),
              SizedBox(
                height: 28,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  bool authSuccessful = await Authentication.authentication();
                  print("Authentication result: $authSuccessful");

                  if (authSuccessful) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClientPage()),
                    );
                  } else {
                    // Gérer les différents cas d'échec d'authentification ici
                  }
                },
                icon: Icon(Icons.fingerprint),
                label: Text("Authentification"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Authentication {
  static final _authen = LocalAuthentication();

  static Future<bool> canAuthenticate() async =>
      await _authen.canCheckBiometrics || await _authen.isDeviceSupported();

  static Future<bool> authentication() async {
    try {
      if (!await canAuthenticate()) return false;

      return await _authen.authenticate(
        localizedReason: AuthenticationPageState.localizedReason,
      );
    } catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }
}
