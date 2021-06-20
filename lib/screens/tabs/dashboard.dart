import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/models/DailyEntry.dart';
import 'package:sadhana_report/screens/entry/add_daily_entry.dart';
import 'package:sadhana_report/screens/entry/daily_entry_detail.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestore = Provider.of<FirestoreService>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Dashboard",style: GoogleFonts.nunito(),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDaily(), fullscreenDialog: true));
        },
        label: Text("Add Entry"),
        icon: Icon(Icons.create),
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
            child: StreamBuilder<List<DailyEntry>>(
              stream: _firestore.getOneWeekEntry(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.length==0){
                      return  Center(child: Text("No Entry Created"),);
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => DailyEntryDetail(
                                            dailyEntry: snapshot.data![i])));
                                  },
                                  leading: Icon(Icons.date_range_rounded),
                                  title: Text(
                                      "${snapshot.data![i].date!.toDate().toString().split(" ").first}"),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("Are you sure?"),
                                                content: Text(
                                                    "Do you want to delete this entry?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await _firestore.deleteEntry(
                                                            docId: snapshot
                                                                .data![i].date!
                                                                .toDate()
                                                                .toString()
                                                                .split(" ")
                                                                .first);
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                              ));
                                    },
                                    icon: Icon(Icons.delete_forever),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                )
                              ],
                            ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
