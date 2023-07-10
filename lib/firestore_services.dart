import 'package:absensi_app/models/absen_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future<void> addAbsensi(AbsenModel absensi) async {
    await FirebaseFirestore.instance
        .collection("absensi")
        .add(absensi.toJson());
  }
  static Future<void> editAbsensi(AbsenModel absensi,String id)async{
    await FirebaseFirestore.instance.collection("absensi").doc(id).update(absensi.toJson());
  }
}
