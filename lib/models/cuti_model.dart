class CutiModel {
  int? id;
  String? startCuti, endCuti,reason,atasanName ;

  CutiModel(
      {this.id,this.startCuti,this.endCuti,this.reason,this.atasanName});

  factory CutiModel.fromJson(Map<String, dynamic> json) {
    return CutiModel(
      id: json['id'],
      startCuti: json['start_cuti'],
      endCuti: json['end_cuti'],
      reason: json['reason'],
      atasanName: json['atasan_name'],
    );
  }
}
