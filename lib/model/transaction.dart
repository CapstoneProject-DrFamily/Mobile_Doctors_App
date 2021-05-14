class Transaction {
  int doctorId, patientId, prescriptionId, status, examId, scheduleId;
  String transactionId, location, note, estimatedTime, reasonCancel;
  String dateStart, dateEnd;

  Transaction(
      {this.transactionId,
      this.doctorId,
      this.patientId,
      this.prescriptionId,
      this.status,
      this.examId,
      this.location,
      this.note,
      this.estimatedTime,
      this.dateStart,
      this.dateEnd,
      this.scheduleId,
      this.reasonCancel});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['id'] as String,
      doctorId: json['doctorId'] as int,
      patientId: json['patientId'] as int,
      prescriptionId: json['prescriptionId'] as int,
      status: json['status'] as int,
      examId: json['examId'] as int,
      location: json['location'] as String,
      note: json['note'] as String,
      estimatedTime: json['estimatedTime'] as String,
      dateStart: json['dateStart'] as String,
      dateEnd: json['dateEnd'] as String,
      reasonCancel: json['reasonCancel'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": transactionId,
        "doctorId": doctorId,
        "patientId": patientId,
        "prescriptionId": prescriptionId,
        "status": status,
        "examId": examId,
        "location": location,
        "note": note,
        "estimatedTime": estimatedTime,
        "dateStart": dateStart,
        "dateEnd": dateEnd,
        "scheduleId": scheduleId,
        "reasonCancel": reasonCancel,
      };
}
