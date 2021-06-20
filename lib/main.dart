import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/screens/landing_page.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_)=>AuthService(),),
        Provider(create: (_)=>FirestoreService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: GoogleFonts.nunitoTextTheme(TextTheme(headline1: GoogleFonts.nunito(color: Colors.white))),
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.nunitoTextTheme()
        ),
        home: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Something went wrong"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return LandingPage();
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
