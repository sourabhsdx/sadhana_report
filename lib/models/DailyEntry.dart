import 'package:cloud_firestore/cloud_firestore.dart';

class DailyEntry {
  Timestamp? date;
  String? day;
  String? wakeup;
  String? mangalarati;
  String? narasimha;
  String? sikshastakam;
  String? chantB412;
  String? spbr;
  String? lecture;
  String? seva;
  String? studyWork;
  String? sleep;
  String? marks;

  DailyEntry(
      {this.date,
        this.day,
        this.wakeup,
        this.mangalarati,
        this.narasimha,
        this.sikshastakam,
        this.chantB412,
        this.spbr,
        this.lecture,
        this.seva,
        this.studyWork,
        this.sleep,
        this.marks});

  DailyEntry.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    wakeup = json['wakeup'];
    mangalarati = json['mangalarati'];
    narasimha = json['narasimha'];
    sikshastakam = json['sikshastakam'];
    chantB412 = json['chant_b412'];
    spbr = json['spbr'];
    lecture = json['lecture'];
    seva = json['seva'];
    studyWork = json['study_work'];
    sleep = json['sleep'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['wakeup'] = this.wakeup;
    data['mangalarati'] = this.mangalarati;
    data['narasimha'] = this.narasimha;
    data['sikshastakam'] = this.sikshastakam;
    data['chant_b412'] = this.chantB412;
    data['spbr'] = this.spbr;
    data['lecture'] = this.lecture;
    data['seva'] = this.seva;
    data['study_work'] = this.studyWork;
    data['sleep'] = this.sleep;
    data['marks'] = this.marks;
    return data;
  }
}
