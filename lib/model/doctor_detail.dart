class DoctorDetail {
  // int doctorId, specialtyId, profileId;
  // String degree, experience, description, school;
  String fullName, dob, gender, phone, image, email, idCard;
  int profileId;
  String degree, experience, description, school;
  int specialtyId;

  // DoctorDetail(
  //     {this.doctorId,
  //     this.degree,
  //     this.experience,
  //     this.description,
  //     this.profileId,
  //     this.school,
  //     this.specialtyId});

  DoctorDetail(
      {this.profileId,
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

  factory DoctorDetail.fromJson(Map<String, dynamic> json) {
    return DoctorDetail(
      profileId: json['id'] as int,
      fullName: json['fullname'] as String,
      dob: json['birthday'] as String,
      gender: json['gender'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      email: json['email'] as String,
      idCard: json['idCard'] as String,
      degree: json['degree'] as String,
      experience: json['experience'] as String,
      description: json['description'] as String,
      specialtyId: json['specialtyId'] as int,
      school: json['school'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": profileId,
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
