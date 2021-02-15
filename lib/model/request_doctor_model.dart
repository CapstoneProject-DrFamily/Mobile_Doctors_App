class RequestDoctorModel {
  final int doctorId;
  final String doctorName, doctorSpecialty, doctorImage;

  RequestDoctorModel({
    this.doctorId,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorImage,
  });

  factory RequestDoctorModel.fromJson(Map<String, dynamic> json) {
    return RequestDoctorModel(
      doctorId: json['doctorId'] as int,
      doctorName: json['doctorName'] as String,
      doctorSpecialty: json['doctorSpecialty'] as String,
      doctorImage: json['doctorImage'] as String,
    );
  }
}
