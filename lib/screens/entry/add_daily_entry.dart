import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sadhana_report/constants.dart';
import 'package:sadhana_report/models/DailyEntry.dart';
import 'package:sadhana_report/services/cloud_firestore.dart';
import 'package:sadhana_report/services/firebase_auth.dart';

class AddDaily extends StatefulWidget {
  @override
  _AddDailyState createState() => _AddDailyState();
}

class _AddDailyState extends State<AddDaily> {
  String date = DateTime.now().toString().split(' ').first;
  String time =
      '${TimeOfDay.now().hour}:${TimeOfDay.now().minute < 10 ? '0' : ''}${TimeOfDay.now().minute}';
  DailyEntry _dailyEntry = DailyEntry();
  bool _showProgress = false;
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dailyEntry.date = Timestamp.now();
    _dailyEntry.day = _dateByDateTime(DateTime.now());
    _dailyEntry.wakeup = time;
    _dailyEntry.mangalarati = time;
    _dailyEntry.narasimha = time;
    _dailyEntry.sikshastakam = time;
    _dailyEntry.chantB412 = "Yes";
    _dailyEntry.lecture = "Yes";
    _dailyEntry.seva = "Yes";
    _dailyEntry.studyWork = "2";
    _dailyEntry.sleep = time;
    _dailyEntry.marks = '0';
    _dailyEntry.spbr = "Yes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Daily Entry"),
        actions: [
          TextButton(onPressed: () => _saveData(context), child: Text("Save"))
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width <= 600
                  ? MediaQuery.of(context).size.width
                  : 600,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () async {
                        DateTime? dateSelected = await showDialog<DateTime>(
                            context: context,
                            builder: (context) {
                              return DatePickerDialog(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                            });
                        setState(() {
                          if (dateSelected != null) {
                            _dailyEntry.date =
                                Timestamp.fromDate(dateSelected);
                            _dailyEntry.day = _dateByDateTime(dateSelected);
                          }
                        });
                      },
                      leading: Icon(Icons.date_range),
                      title: Text(
                          '${_dailyEntry.date!.toDate().toString().split(" ").first}'),
                      subtitle: Text("Date"),
                      trailing: Text("Change"),
                    ),
                    ListTile(
                      onTap: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: _timeOfDay);
                        if (timeSelected != null) {
                          setState(() {
                            _dailyEntry.wakeup =
                            '${timeSelected.hour > 12 ? timeSelected.hour - 12 : timeSelected.hour}:${timeSelected.minute < 10 ? '0' : ''}${timeSelected.minute}';
                            _timeOfDay = timeSelected;
                          });
                        }
                      },
                      leading: Icon(Icons.timer),
                      title: Text('${_dailyEntry.wakeup}'),
                      subtitle: Text("Wake Up Time"),
                      trailing: Text("Change"),
                    ),
                    ListTile(
                      onTap: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: _timeOfDay);
                        if (timeSelected != null) {
                          setState(() {
                            _dailyEntry.mangalarati =
                            '${timeSelected.hour > 12 ? timeSelected.hour - 12 : timeSelected.hour}:${timeSelected.minute < 10 ? '0' : ''}${timeSelected.minute}';
                            _timeOfDay = timeSelected;
                          });
                        }
                      },
                      leading: Icon(Icons.timer),
                      title: Text('${_dailyEntry.mangalarati}'),
                      subtitle: Text("Mangal Arati"),
                      trailing: Text("Change"),
                    ),
                    ListTile(
                      onTap: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: _timeOfDay);
                        if (timeSelected != null) {
                          setState(() {
                            _dailyEntry.narasimha =
                            '${timeSelected.hour > 12 ? timeSelected.hour - 12 : timeSelected.hour}:${timeSelected.minute < 10 ? '0' : ''}${timeSelected.minute}';
                            _timeOfDay = timeSelected;
                          });
                        }
                      },
                      leading: Icon(Icons.timer),
                      title: Text('${_dailyEntry.narasimha}'),
                      subtitle: Text("Nrisimha"),
                      trailing: Text("Change"),
                    ),
                    ListTile(
                      onTap: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: _timeOfDay);
                        if (timeSelected != null) {
                          setState(() {
                            _dailyEntry.sikshastakam =
                            '${timeSelected.hour > 12 ? timeSelected.hour - 12 : timeSelected.hour}:${timeSelected.minute < 10 ? '0' : ''}${timeSelected.minute}';
                            _timeOfDay = timeSelected;
                          });
                        }
                      },
                      leading: Icon(Icons.timer),
                      title: Text('${_dailyEntry.sikshastakam}'),
                      subtitle: Text("Siksha Astakam"),
                      trailing: Text("Change"),
                    ),
                    ListTile(
                      leading: Icon(Icons.verified),
                      title: DropdownButton(
                        value: _dailyEntry.chantB412,
                        items: [
                          DropdownMenuItem(
                            child: Text("Yes"),
                            value: "Yes",
                          ),
                          DropdownMenuItem(
                            child: Text("No"),
                            value: "No",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dailyEntry.chantB412 = value.toString();
                          });
                        },
                      ),
                      subtitle: Text("Chanting Before 12 NOON"),
                      // trailing: Text("Select"),
                    ),
                    ListTile(
                      leading: Icon(Icons.verified),
                      title: DropdownButton(
                        value: _dailyEntry.spbr,
                        items: [
                          DropdownMenuItem(
                            child: Text("Yes"),
                            value: "Yes",
                          ),
                          DropdownMenuItem(
                            child: Text("No"),
                            value: "No",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dailyEntry.spbr = value.toString();
                          });
                        },
                      ),
                      subtitle: Text("Shrila Prabhupad's Book Reading"),
                      // trailing: Text("Select"),
                    ),
                    ListTile(
                      leading: Icon(Icons.verified),
                      title: DropdownButton(
                        value: _dailyEntry.lecture,
                        items: [
                          DropdownMenuItem(
                            child: Text("Yes"),
                            value: "Yes",
                          ),
                          DropdownMenuItem(
                            child: Text("No"),
                            value: "No",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dailyEntry.lecture = value.toString();
                          });
                        },
                      ),
                      subtitle: Text("Lecture Hearing"),
                      // trailing: Text("Select"),
                    ),
                    ListTile(
                      leading: Icon(Icons.verified),
                      title: DropdownButton(
                        value: _dailyEntry.seva,
                        items: [
                          DropdownMenuItem(
                            child: Text("Yes"),
                            value: "Yes",
                          ),
                          DropdownMenuItem(
                            child: Text("No"),
                            value: "No",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dailyEntry.seva = value.toString();
                          });
                        },
                      ),
                      subtitle: Text("SEVA"),
                      // trailing: Text("Select"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onChanged: (value) => _dailyEntry.studyWork = value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText:
                                "Study time or Household work in Hours",
                            hintText: "Study time or Household work in Hours",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (timeSelected != null) {
                          setState(() {
                            _dailyEntry.sleep =
                                '${timeSelected.hour > 12 ? timeSelected.hour - 12 : timeSelected.hour}:${timeSelected.minute < 10 ? '0' : ''}${timeSelected.minute}';
                          });
                        }
                      },
                      leading: Icon(Icons.timer),
                      title: Text('${_dailyEntry.sleep}'),
                      subtitle: Text("Sleep Time"),
                      trailing: Text("Change"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onChanged: (value) => _dailyEntry.marks = value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Total Marks",
                            hintText: "Total Marks",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _saveData(context),
                      child: Text("Add New Entry"),
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
            )
          ],
        ),
      ),
    );
  }

  _saveData(BuildContext context) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    FirestoreService firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    setState(() {
      _showProgress = true;
    });
    try {
      await firestoreService.addDailyEntry(
          dailyEntry: _dailyEntry, uid: authService.currentUser()!.uid);
    } on FirebaseException catch (e) {
      setState(() {
        _showProgress = false;
      });
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("${e.message}"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Ok"))
              ],
            );
          });
    }
    setState(() {
      _showProgress = false;
    });
    Navigator.of(context).pop();
  }

  String? _dateByDateTime(DateTime dateSelected) {
    String _day = "";
    switch (dateSelected.weekday) {
      case DateTime.sunday:
        _day = "Sunday";
        break;
      case DateTime.monday:
        _day = "Monday";
        break;
      case DateTime.tuesday:
        _day = "Tuesday";
        break;
      case DateTime.wednesday:
        _day = "Wednesday";
        break;
      case DateTime.thursday:
        _day = "Thursday";
        break;
      case DateTime.friday:
        _day = "Friday";
        break;
      case DateTime.saturday:
        _day = "Saturday";
        break;
    }
    return _day;
  }
}
