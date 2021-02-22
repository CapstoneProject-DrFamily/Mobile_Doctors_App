class CreateProfileModel {
  final String fullName, dob, gender, phone, image, email, idCard;

  CreateProfileModel(
      {this.fullName,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard});

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "birthday": dob,
        "gender": gender,
        "phone": phone,
        "image": image,
        "email": email,
        "idCard": idCard,
      };
}
