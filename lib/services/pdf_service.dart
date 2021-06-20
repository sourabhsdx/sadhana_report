import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:sadhana_report/models/BasicData.dart';
import 'package:sadhana_report/models/DailyEntry.dart';

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfApi {
  static Future<File> generateSadhanaReport(
      {BasicData? basicData, List<DailyEntry>? dailyEntries}) async {
    final pdf = Document();
    final font = Font.ttf(await rootBundle.load("assets/OpenSans-Regular.ttf"));
    final fontBold = Font.ttf(await rootBundle.load("assets/OpenSans-Bold.ttf"));
    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a3,
      margin: EdgeInsets.all(40),
    );

    final headers = [
      "Date",
      "Day",
      "Wake Up Time",
      "MANGAL ARATI",
      "NRISIMHA ARATI",
      "SIKSA ASTAKAM",
      "CHANTING BEFORE 12AM",
      "SRILA PRABHUPADA BOOKS READING",
      "LECTURE HEARING",
      "SEVA",
      "HOURS OF ACADEMIC STUDY FOR STUDENTS/ HOUSEHOLD ACTIVITIES FOR WORKING STUDENTS",
      "SLEEP TIME & DAILY SADHANA ENTRY",
      "TOTAL MARKS (200 MARKS)"
    ];

    final data = dailyEntries!
        .map((e) => [
              e.date!.toDate().toString().split(" ").first,
              e.day,
              e.wakeup,
              e.mangalarati,
              e.narasimha,
              e.sikshastakam,
              e.chantB412,
              e.spbr,
              e.lecture,
              e.seva,
              e.studyWork,
              e.sleep,
              e.marks
            ])
        .toList();

    pdf.addPage(MultiPage(
        pageTheme: pageTheme,
        build: (context) {
          return [
            Header(
                level: 0,
                child: Center(
                    child: Text(
                  "${basicData!.iYF}",
                  style: TextStyle(font: font, fontSize: 20),
                ))),
            Center(
                child: Paragraph(
              style: TextStyle(font: font,fontSize: 20),
              text:
                  "Name:....${basicData.fullName}...... Address: ....${basicData.address}... ",
            )),
            Center(
                child: Paragraph(
              style: TextStyle(font: font,fontSize: 20),
              text:
                  "No of rounds Chanting:..${basicData.rounds}... Month:........................",
            )),
            Table.fromTextArray(
                headerStyle: TextStyle(font: font, fontSize: 9),
                cellStyle: TextStyle(font: font),
                columnWidths: {
                  0: FixedColumnWidth(300),
                  1: FixedColumnWidth(310),
                  2: FixedColumnWidth(170),
                  3: FixedColumnWidth(200),
                  4: FixedColumnWidth(230),
                  5: FixedColumnWidth(220),
                  6: FixedColumnWidth(290),
                  8: FixedColumnWidth(220),
                  9: FixedColumnWidth(150),
                  10: FixedColumnWidth(350),
                  12: FixedColumnWidth(300)
                },
                data: data,
                headers: headers),
            SizedBox(height: 30),
            Header(level: 1,text: "INSTRUCTIONS:",textStyle: TextStyle(font: font,fontBold: fontBold)),
            Paragraph(text: "1) 25 marks for Waking up before 5am",style:TextStyle(font: font)),
            Paragraph(text: "2) 25 marks for Mangal Arati",style:TextStyle(font: font)),
            Paragraph(text: "3) 20 marks for Nrisimha Arati",style:TextStyle(font: font)),
            Paragraph(text: "4) 10 marks for Siksastakam",style:TextStyle(font: font)),
            Paragraph(text: "5) 25 marks for Chanting before 12 Noon",style:TextStyle(font: font)),
            Paragraph(text: "6) 20 marks for Srila mrabhupada Books Reading (20min)",style:TextStyle(font: font)),
            Paragraph(text: "7) 20 marks for Lecture hearing (30min)",style:TextStyle(font: font)),
            Paragraph(text: "8) 10 marks for Seva (30min)",style:TextStyle(font: font)),
            Paragraph(text: "9) 20 marks for Academic study or Household activities",style:TextStyle(font: font)),
            Paragraph(text: "10) 25 marks for Sleep at 10 pm",style:TextStyle(font: font)),
            Paragraph(text: "(-5 for every 30 minutes late for moint no 1 and 5)",style: TextStyle(fontWeight: FontWeight.bold,font: font,fontBold: fontBold)),
            Paragraph(text: "(0 marks for not doing the rest points)",style: TextStyle(fontWeight: FontWeight.bold,font: font,fontBold: fontBold)),
            Paragraph(text: "Servant Leader’s name: .......${basicData.sl}............ Counselor’s signature: ................................................................",style: TextStyle(font: font,fontBold: fontBold,fontWeight:FontWeight.bold))

          ];
        }));
    return saveDocument(name: "sadhana_report.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
