class ProfileModel {
  int? id;
  String? name, nik , bod , position , address ;

  ProfileModel(
      {this.id,this.name,this.nik,this.bod,this.position,this.address});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      nik: json['nik'],
      bod: json['bod'],
      position: json['position'],
      address: json['address'],
    );
  }
}
