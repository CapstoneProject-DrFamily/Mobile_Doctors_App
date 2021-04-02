class RequestDoctorModel {
  final int doctorId, doctorServiceId, doctorFeedBackCount, doctorbooked;
  final String doctorName, doctorSpecialty, doctorImage;
  final double doctorRatingPoint;
  RequestDoctorModel({
    this.doctorId,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorImage,
    this.doctorFeedBackCount,
    this.doctorRatingPoint,
    this.doctorServiceId,
    this.doctorbooked,
  });

  factory RequestDoctorModel.fromJson(Map<String, dynamic> json) {
    return RequestDoctorModel(
      doctorId: json['doctorId'] as int,
      doctorName: json['doctorName'] as String,
      doctorSpecialty: json['doctorSpecialty'] as String,
      doctorImage: json['doctorImage'] as String,
      doctorServiceId: json['doctorServiceId'] as int,
      doctorFeedBackCount: json['feedbackCount'] as int,
      doctorRatingPoint: json['ratingPoint'] as double,
      doctorbooked: json['bookedCount'] as int,
    );
  }
}
