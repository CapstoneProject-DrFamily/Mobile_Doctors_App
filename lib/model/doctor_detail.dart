class DoctorDetail {
  int doctorId, specialtyId, profileId;
  String degree, experience, description, school;

  DoctorDetail(
      {this.doctorId,
      this.degree,
      this.experience,
      this.description,
      this.profileId,
      this.school,
      this.specialtyId});

  factory DoctorDetail.fromJson(Map<String, dynamic> json) {
    return DoctorDetail(
      doctorId: json['doctorId'] as int,
      degree: json['degree'] as String,
      experience: json['experience'] as String,
      description: json['description'] as String,
      specialtyId: json['specialtyId'] as int,
      profileId: json['profileId'] as int,
      school: json['school'] as String,
    );
  }
}
