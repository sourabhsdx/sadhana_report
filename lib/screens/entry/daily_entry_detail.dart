import 'package:flutter/material.dart';
import 'package:sadhana_report/models/DailyEntry.dart';

class DailyEntryDetail extends StatelessWidget {
  final DailyEntry dailyEntry;
  const DailyEntryDetail({Key? key,required this.dailyEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${dailyEntry.date!.toDate().toString().split(" ").first}"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("${dailyEntry.day}"),
            subtitle: Text("Day"),
          ),
          ListTile(
            title: Text("${dailyEntry.wakeup}"),
            subtitle: Text("Wake Up Time"),
          ),
          ListTile(
            title: Text("${dailyEntry.mangalarati}"),
            subtitle: Text("Manga Arati"),
          ),
          ListTile(
            title: Text("${dailyEntry.narasimha}"),
            subtitle: Text("Nrisimha Arati"),
          ),
          ListTile(
            title: Text("${dailyEntry.sikshastakam}"),
            subtitle: Text("Siksa Astakam"),
          ),
          ListTile(
            title: Text("${dailyEntry.chantB412}"),
            subtitle: Text("Chanting Before 12PM"),
          ),
          ListTile(
            title: Text("${dailyEntry.spbr}"),
            subtitle: Text("Srila Prabhupada Book Reading"),
          ),
          ListTile(
            title: Text("${dailyEntry.lecture}"),
            subtitle: Text("Lecture Hearing"),
          ),
          ListTile(
            title: Text("${dailyEntry.seva}"),
            subtitle: Text("Seva"),
          ),
          ListTile(
            title: Text("${dailyEntry.studyWork}"),
            subtitle: Text("Study/Household Work"),
          ),
          ListTile(
            title: Text("${dailyEntry.sleep}"),
            subtitle: Text("Sleep Time"),
          ),
          ListTile(
            title: Text("${dailyEntry.marks}"),
            subtitle: Text("Total Marks Out of 200"),
          )
        ],
      ),
    );
  }
}
