class CreateDoctorModel {
  final String degree, experience, description, school;
  final int specialtyId, doctorId;

  CreateDoctorModel(
      {this.degree,
      this.description,
      this.experience,
      this.specialtyId,
      this.school,
      this.doctorId});

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "experience": experience,
        "description": description,
        "specialtyId": specialtyId,
        "school": school,
        "doctorId": doctorId,
      };
}
