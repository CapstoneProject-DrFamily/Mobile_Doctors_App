class Transaction {
  int doctorId, patientId, prescriptionId, status, examId;
  String transactionId, location, note, estimatedTime;

  Transaction(
      {this.transactionId,
      this.doctorId,
      this.patientId,
      this.prescriptionId,
      this.status,
      this.examId,
      this.location,
      this.note,
      this.estimatedTime});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        transactionId: json['transactionId'] as String,
        doctorId: json['doctorId'] as int,
        patientId: json['patientId'] as int,
        prescriptionId: json['prescriptionId'] as int,
        status: json['status'] as int,
        examId: json['examId'] as int,
        location: json['location'] as String,
        note: json['note'] as String,
        estimatedTime: json['estimatedTime'] as String);
  }

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "doctorId": doctorId,
        "patientId": patientId,
        "prescriptionId": prescriptionId,
        "status": status,
        "examId": examId,
        "location": location,
        "note": note,
        "estimatedTime": estimatedTime
      };
}
