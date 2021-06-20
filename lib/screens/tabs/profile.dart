import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/models/BasicData.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    FirestoreService _firestore = Provider.of<FirestoreService>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width<=600?MediaQuery.of(context).size.width:600,
            decoration: BoxDecoration(
                color: kLightColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
            ),
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    foregroundImage:
                        NetworkImage(authService.currentUser()!.photoURL??"https://ui-avatars.com/api/?name=S+R"),
                  ),
                  title: Text("${authService.currentUser()!.displayName}"),
                  subtitle: Text("${authService.currentUser()!.email}"),
                  trailing: authService.currentUser()!.emailVerified
                      ? Icon(Icons.verified)
                      : Icon(Icons.warning),
                ),
                ListTile(
                  onTap: () async {
                    AuthService _authService =
                        Provider.of<AuthService>(context, listen: false);
                    await _authService.logOut();
                  },
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
                FutureBuilder<BasicData>(
                    future: _firestore.getBasicData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              ListTile(
                                leading:Icon(Icons.person),
                                title: Text("${snapshot.data!.fullName}"),
                                subtitle: Text("Name"),
                              ),
                              ListTile(
                                leading:Icon(Icons.group),
                                title: Text("${snapshot.data!.sl}"),
                                subtitle: Text("Servant Leader"),
                              ),
                              ListTile(
                                leading:Icon(Icons.location_on_outlined),
                                title: Text("${snapshot.data!.iYF}"),
                                subtitle: Text("IYF name"),
                              ),
                              ListTile(
                                leading:Icon(Icons.person),
                                title: Text("${snapshot.data!.counsellor}"),
                                subtitle: Text(" Counsellor Name"),
                              ),
                              ListTile(
                                leading:Icon(Icons.person),
                                title: Text("${snapshot.data!.rounds}"),
                                subtitle: Text("No of rounds chanting"),
                              ),
                            ],
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error Loading Basic Data!"),
                          );
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.help_outline),title: Text("Help & Support"),
                  subtitle: Text("Mail: connect@dreamndevelop.com"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
