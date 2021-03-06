import 'package:mobile_doctors_apps/model/patient_transacion/additional_info.dart';

class ProfileModel {
  int profileId;
  String fullName, dob, gender, phone, image, email, idCard;
  AdditionInfoModel additionInfoModel;

  ProfileModel(
      {this.profileId,
      this.fullName,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileId: json['id'] as int,
      fullName: json['fullname'] as String,
      dob: json['birthday'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      idCard: json['idCard'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "profileId": this.profileId,
        "fullName": this.fullName,
        "birthday": this.dob,
        "gender": this.gender,
        "phone": this.phone,
        "image": this.image,
        "email": this.email,
        "idCard": this.idCard,
      };
}
