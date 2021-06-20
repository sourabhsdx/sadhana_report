import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/models/BasicData.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class AddBasicData extends StatefulWidget {
  @override
  _AddBasicDataState createState() => _AddBasicDataState();
}

class _AddBasicDataState extends State<AddBasicData> {

  BasicData _basicData = BasicData();
  bool _showProgress = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Basic Data"),

      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width <= 400
                      ? MediaQuery.of(context).size.width
                      : 400,
                  height: MediaQuery.of(context).size.height <= 700
                      ? MediaQuery.of(context).size.height
                      : 700,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your name";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.fullName=value,
                          onSaved: (value)=>_basicData.fullName=value,
                          decoration: InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your contact no";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.contactNo=value,
                          onSaved: (value)=>_basicData.contactNo=value,
                          decoration: InputDecoration(
                              labelText: "Contact No.",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your short address";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.address=value,
                          onSaved: (value)=>_basicData.address=value,
                          decoration: InputDecoration(
                              labelText: "Short Address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter no of rounds";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.rounds=int.parse(value),
                          onSaved: (value)=>_basicData.rounds=int.parse(value??'0'),
                          decoration: InputDecoration(
                              labelText: "No of rounds chanting",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter IYF Name or City";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.iYF=value,
                          onSaved: (value)=>_basicData.iYF=value,
                          decoration: InputDecoration(
                              labelText: "IYF",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your counsellor's name";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.counsellor=value,
                          onSaved: (value)=>_basicData.counsellor=value,
                          decoration: InputDecoration(
                              labelText: "Counsellor Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your servant leader name";
                            }

                            return null;

                          },
                          onChanged: (value)=>_basicData.sl=value,
                          onSaved: (value)=>_basicData.sl=value,
                          decoration: InputDecoration(
                              labelText: "Servant Leader",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28))),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: ()=>_saveData(context), child: Text("Save Details"),style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)
                            )
                        )),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveData(BuildContext context) async {
    AuthService authService = Provider.of<AuthService>(context,listen: false);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context,listen: false);
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      setState(() {
        _showProgress = true;
      });
      _basicData.uid = authService.currentUser()!.uid;
      _basicData.email = authService.currentUser()!.email;
      try{
        await firestoreService.addBasicData(basicData: _basicData);
        setState(() {
          _showProgress = false;
        });
        Navigator.of(context).pop(true);
      } on FirebaseException catch(e){
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



    }
  }
}
