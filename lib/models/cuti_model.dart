
import 'package:cloud_firestore/cloud_firestore.dart';

class CutiModel {
  String startCuti, endCuti, reason,atasanName;

  CutiModel(
      {required this.startCuti, required this.endCuti, required this.reason,required this.atasanName});

  Map<String, dynamic> toJson() {
    return {"start_cuti": startCuti, "end_cuti": endCuti, "reason": reason,"atasan_name":atasanName};
  }

  factory CutiModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return CutiModel(
        startCuti: json["start_cuti"], endCuti: 'end_cuti', reason: "reason",atasanName:"atasan_name");
  }
}
