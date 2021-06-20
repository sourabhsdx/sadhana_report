import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/screens/home.dart';
import 'package:sadhana_report/screens/welcome.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
        stream: authService.onAuthStateChange(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            if (snap.data == null) {
              return WelcomePage();
            }
            return HomePage();
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
