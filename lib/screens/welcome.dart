import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/screens/login.dart';
import 'package:sadhana_report/screens/register.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      // appBar: AppBar(title: Text("Welcome"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: kLightColor,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width <= 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: [
                      Hero(
                        tag: 'text',
                        child: Text(
                          "Welcome",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: 'logo',
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"))),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Text("Let's get started",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Register(),
                              fullscreenDialog: true));
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.nunito(),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.white))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kAccent)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Login(),
                              fullscreenDialog: true));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.nunito(),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.white)))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
