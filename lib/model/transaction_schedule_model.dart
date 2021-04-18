class TransactionScheduleModel {
  String transactionId,
      dateStart,
      location,
      note,
      patientName,
      relationship,
      serviceName;
  int patientId, transactionStatus;
  double servicePrice;
  bool isOldPatient;

  TransactionScheduleModel(
      {this.dateStart,
      this.isOldPatient,
      this.location,
      this.note,
      this.patientId,
      this.patientName,
      this.relationship,
      this.serviceName,
      this.servicePrice,
      this.transactionId,
      this.transactionStatus});

  factory TransactionScheduleModel.fromJson(Map<String, dynamic> json) {
    return TransactionScheduleModel(
      transactionId: json['transactionId'] as String,
      patientId: json['patientId'] as int,
      dateStart: json['dateStart'] as String,
      transactionStatus: json['status'] as int,
      location: json['location'] as String,
      note: json['note'] as String,
      patientName: json['patientName'] as String,
      relationship: json['relationship'] as String,
      serviceName: json['serviceName'] as String,
      servicePrice: json['servicePrice'] as double,
      isOldPatient: json['isOldPatient'] as bool,
    );
  }
}
