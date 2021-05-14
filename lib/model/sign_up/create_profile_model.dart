class CreateProfileModel {
  final String fullName, dob, gender, phone, image, email, idCard;
  final int accountId;
  final String degree, experience, description, school;
  final int specialtyId;

  CreateProfileModel(
      {this.accountId,
      this.fullName,
      this.dob,
      this.gender,
      this.phone,
      this.image,
      this.email,
      this.idCard,
      this.degree,
      this.experience,
      this.description,
      this.specialtyId,
      this.school});

  Map<String, dynamic> toJson() => {
        "id": accountId,
        "fullname": fullName,
        "birthday": dob,
        "gender": gender,
        "phone": phone,
        "image": image,
        "email": email,
        "idCard": idCard,
        "degree": degree,
        "experience": experience,
        "description": description,
        "specialtyId": specialtyId,
        "school": school,
      };
}
