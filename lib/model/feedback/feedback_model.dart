class FeedbackModel {
  String feedbackId;
  double ratingPoint;
  int patientId, doctorId;
  String note;

  FeedbackModel({
    this.feedbackId,
    this.ratingPoint,
    this.patientId,
    this.doctorId,
    this.note,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      feedbackId: json['feedbackId'] as String,
      ratingPoint: json['ratingPoint'] as double,
      patientId: json['patientId'] as int,
      doctorId: json['doctorId'] as int,
      note: json['note'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "feedbackId": this.feedbackId,
        "ratingPoint": this.ratingPoint,
        "patientId": this.patientId,
        "doctorId": this.doctorId,
        "note": this.note,
      };
}
