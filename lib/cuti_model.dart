class CutiModel {
  int? id;
  String? startCuti, endCuti ;

  CutiModel(
      {this.id,this.startCuti,this.endCuti});

  factory CutiModel.fromJson(Map<String, dynamic> json) {
    return CutiModel(
      id: json['id'],
      startCuti: json['start_cuti'],
      endCuti: json['end_cuti'],
    );
  }
}
