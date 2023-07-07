import 'package:cloud_firestore/cloud_firestore.dart';

class AbsenModel {
  String today, comeIn, comeOut;

  AbsenModel(
      {required this.today, required this.comeIn, required this.comeOut});

  Map<String, dynamic> toJson() {
    return {"today": today, "come_in": comeIn, "come_out": comeOut};
  }

  factory AbsenModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return AbsenModel(
        today: json["today"], comeIn: 'come_in', comeOut: "come_out");
  }
}
