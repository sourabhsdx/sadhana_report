import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/screens/basic_data.dart';
import 'package:sadhana_report/screens/tabs/dashboard.dart';
import 'package:sadhana_report/screens/tabs/export.dart';
import 'package:sadhana_report/screens/tabs/profile.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var _listTabs = [Dashboard(), Export(), Profile()];
  @override
  void initState() {
    // TODO: implement initState
    _checkBasicData();
    super.initState();

  }

  Future<void> _checkBasicData() async {
    AuthService authService = Provider.of<AuthService>(context,listen: false);
    FirestoreService firestoreService = Provider.of<FirestoreService>(context,listen: false);
    if(await firestoreService.checkDoc(path: "basicData/${authService.currentUser()!.uid}")){
      print("true");
    }
    else{
      bool? added = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (context)=>AddBasicData()));
      if(added!=null){
        if(added ==true){
          return;
        }
      }
      else{
        _checkBasicData();
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _listTabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Export"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "My Profile")
        ],
      ),
    );
  }
}
