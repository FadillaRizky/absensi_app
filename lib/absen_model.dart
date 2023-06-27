class AbsenModel {
  int? id;
  String? today, comeIn , comeOut ;

  AbsenModel(
      {this.id,this.today,this.comeIn,this.comeOut});

  factory AbsenModel.fromJson(Map<String, dynamic> json) {
    return AbsenModel(
      id: json['id'],
      today: json['today'],
      comeIn: json['come_in'],
      comeOut: json['come_out'],
    );
  }
}
