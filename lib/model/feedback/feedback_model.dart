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
      feedbackId: json['id'] as String,
      ratingPoint: json['ratingPoint'] as double,
      note: json['note'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "feedbackId": this.feedbackId,
        "ratingPoint": this.ratingPoint,
        "note": this.note,
      };
}
