class CreateDoctorModel {
  final String degree, experience, description, school;
  final int specialtyId, profileId;

  CreateDoctorModel(
      {this.degree,
      this.description,
      this.experience,
      this.specialtyId,
      this.profileId,
      this.school});

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "experience": experience,
        "description": description,
        "specialtyId": specialtyId,
        "profileId": profileId,
        "school": school,
      };
}
