import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/screens/register.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(""),
        elevation: 0,
      ),
      backgroundColor: kSecondaryColor,
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                    color: kLightColor,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width <= 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "logo",
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"))),
                        ),
                      ),
                      Hero(
                        tag: "text",
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                      style: GoogleFonts.nunito(),
                        validator: (value) {
                          if (value == null) {
                            return "Enter a valid Email Address";
                          }
                          if (value.contains("@")) {
                            return null;
                          }
                        },
                        onChanged: (value) => email = value,
                        onSaved: (value) => email = value!,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: GoogleFonts.nunito(),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                        onChanged: (value) => password = value,
                        onSaved: (value) => password = value!,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => _login(context),
                        child: Text("Login",style: GoogleFonts.nunito()),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.white)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>Register()));
                          }, child: Text("Create an Account",style: GoogleFonts.nunito(),)),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {}, child: Text("Forgot Password?",style: GoogleFonts.nunito(),))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _showProgress = true;
      });
      try {
        await authService.login(email: email, password: password);
      } on FirebaseAuthException catch(e){
        setState(() {
          _showProgress = false;
        });
        await showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text("Alert"),
            content: Text("${e.message}"),
            actions: [
              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Ok"))
            ],
          );
        });
      }
      setState(() {
        _showProgress = false;
      });
      Navigator.of(context).pop();
    }
  }
}
