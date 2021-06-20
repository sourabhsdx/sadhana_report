import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sadhana_report/models/BasicData.dart';
import 'package:sadhana_report/models/DailyEntry.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addBasicData({required BasicData basicData}) async {
    try {
      await _firestore
          .collection('basicData')
          .doc(basicData.uid)
          .set(basicData.toJson());
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<bool> checkDoc({required String path}) async {
    DocumentSnapshot snapshot = await _firestore.doc(path).get();
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

  Future<void> addDailyEntry(
      {required DailyEntry dailyEntry, required String uid}) async {
    try {
      await _firestore
          .collection(uid)
          .doc(dailyEntry.date!.toDate().toString().split(" ").first)
          .set(dailyEntry.toJson());
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<void> deleteEntry({ required String docId}) async {
    String _uid = _firebaseAuth.currentUser!.uid;
    await _firestore.collection(_uid).doc(docId).delete();
  }

  Stream<List<DailyEntry>> getOneWeekEntry() {
    String _uid = _firebaseAuth.currentUser!.uid;
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> _snapshot = _firestore
          .collection(_uid)
          .orderBy("date", descending: true)
          .limit(10)
          .snapshots();
      return _snapshot.map((event) =>
          event.docs.map((e) => DailyEntry.fromJson(e.data())).toList());
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<List<DailyEntry>> getLastWeekEntry() async {
    String _uid = _firebaseAuth.currentUser!.uid;
    try {
      QuerySnapshot<Map<String, dynamic>> _snap = await _firestore
          .collection(_uid)
          .where("date",
              isGreaterThanOrEqualTo: Timestamp.fromDate(
                  DateTime.now().subtract(Duration(days: 7))))
          .where("date", isLessThanOrEqualTo: Timestamp.now())
          .orderBy("date")
          .get();
      return _snap.docs.map((e) => DailyEntry.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<List<DailyEntry>> getEntry({required DateTime from,required DateTime to}) async {
    String _uid = _firebaseAuth.currentUser!.uid;
    try {
      QuerySnapshot<Map<String, dynamic>> _snap = await _firestore
          .collection(_uid)
          .where("date",
          isGreaterThanOrEqualTo: Timestamp.fromDate(from))
          .where("date", isLessThanOrEqualTo: Timestamp.fromDate(to))
          .orderBy("date")
          .get();
      return _snap.docs.map((e) => DailyEntry.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<BasicData> getBasicData() async {
    try {
      String _uid = _firebaseAuth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> _snap = await _firestore.doc(
          "basicData/$_uid").get();
      return BasicData.fromJson(_snap.data()!);
    } on FirebaseException catch(e){
      throw e;
    }
  }
}
