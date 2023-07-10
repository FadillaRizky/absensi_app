import 'package:absensi_app/models/absen_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/cuti_model.dart';

class FirestoreService {
  static Future<void> addAbsensi(AbsenModel absensi) async {
    await FirebaseFirestore.instance
        .collection("absensi")
        .doc(DateTime.now().toString())
        .set(absensi.toJson());
  }
  static Future<void> editAbsensi(Map<String,dynamic> absensi,String uid)async{
    FirebaseFirestore.instance.collection("absensi").doc(uid).set(absensi,SetOptions(merge: true),);
  }

  static Future<void> addCuti(CutiModel cuti) async {
    await FirebaseFirestore.instance
        .collection("cuti")
        .add(cuti.toJson());
  }
}
