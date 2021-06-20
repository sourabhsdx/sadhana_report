import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/models/BasicData.dart';
import 'package:sadhana_report/models/DailyEntry.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/pdf_service.dart';

class Export extends StatefulWidget {
  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService _firestore = Provider.of<FirestoreService>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Export"),
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
            child: Column(
              children: [
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    List<DailyEntry> _dailyEntries =
                        await _firestore.getLastWeekEntry();
                    BasicData _basicData = await _firestore.getBasicData();
                    if(_dailyEntries.length==0){
                      return showDialog(context: context, builder:(context)=> AlertDialog(
                        title: Text("Alert"),
                        content: Text("Zero entries found"),
                        actions: [
                          TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK"))
                        ],
                      ));
                    }
                    File _file = await PdfApi.generateSadhanaReport(
                        dailyEntries: _dailyEntries, basicData: _basicData);
                    await PdfApi.openFile(_file);
                  },
                  style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                  child: Text("Export Last 7 Days Report in PDF "),
                ),
                Divider(thickness: 2,color: Colors.blue.withOpacity(0.3),),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                   color: Colors.blue.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                      Text("Custom Range Export",style: GoogleFonts.lato(),),
                      Divider(thickness: 2,color: Colors.blue.withOpacity(0.4),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("From"),
                              OutlinedButton(
                                  onPressed: () async {
                                    DateTimeRange? range = await showDateRangePicker(
                                        context: context,
                                        firstDate:
                                            _fromDate.subtract(Duration(days: 180)),
                                        lastDate: _toDate.add(Duration(days: 180)));
                                    setState(() {
                                      if (range != null) {
                                        _fromDate = range.start;
                                        _toDate = range.end;
                                      }
                                    });
                                  },
                                  child:
                                      Text("${_fromDate.toString().split(" ").first}")),
                            ],
                          ),
                          Column(
                            children: [
                              Text("To"),
                              OutlinedButton(
                                  onPressed: () async {
                                    DateTimeRange? range = await showDateRangePicker(
                                        context: context,
                                        firstDate:
                                            _fromDate.subtract(Duration(days: 180)),
                                        lastDate: _toDate.add(Duration(days: 180)));
                                    setState(() {
                                      if (range != null) {
                                        _fromDate = range.start;
                                        _toDate = range.end;
                                      }
                                    });
                                  },
                                  child:
                                      Text("${_toDate.toString().split(" ").first}")),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(onPressed: () async {
                        List<DailyEntry> _dailyEntries =
                        await _firestore.getEntry(from: _fromDate, to: _toDate);
                        BasicData _basicData = await _firestore.getBasicData();
                        if(_dailyEntries.length==0){
                          return showDialog(context: context, builder:(context)=> AlertDialog(
                            title: Text("Alert"),
                            content: Text("Zero entries found. Try changing the date range."),
                            actions: [
                              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK"))
                            ],
                          ));
                        }
                        File _file = await PdfApi.generateSadhanaReport(
                            dailyEntries: _dailyEntries, basicData: _basicData);
                        await PdfApi.openFile(_file);

                      },
                          style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                          child: Text("Generate PDF Report"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
