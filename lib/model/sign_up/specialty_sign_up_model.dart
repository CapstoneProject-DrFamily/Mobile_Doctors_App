class SpecialtyModel {
  int specialtyId;
  String specialtyImage, specialtyTitle, specialtyDes;

  SpecialtyModel(
      {this.specialtyId,
      this.specialtyImage,
      this.specialtyTitle,
      this.specialtyDes});

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      specialtyId: json['specialtyId'] as int,
      specialtyImage: json['image'] as String,
      specialtyTitle: json['name'] as String,
      specialtyDes: json['description'] as String,
    );
  }
}
