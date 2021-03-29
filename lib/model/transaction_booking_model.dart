class TransactionBookingModel {
  String transactionId,
      dateStart,
      location,
      note,
      doctorName,
      relationShip,
      serviceName,
      patientName;

  double servicePrice;
  int patientId, doctorId, status;

  TransactionBookingModel(
      {this.dateStart,
      this.doctorName,
      this.location,
      this.note,
      this.relationShip,
      this.serviceName,
      this.servicePrice,
      this.transactionId,
      this.status,
      this.patientId,
      this.patientName,
      doctorId});

  factory TransactionBookingModel.fromJson(Map<String, dynamic> json) {
    return TransactionBookingModel(
      transactionId: json['transactionId'] as String,
      patientId: json['patientId'] as int,
      status: json['status'] as int,
      dateStart: json['dateStart'] as String,
      location: json['location'] as String,
      note: json['note'] as String,
      patientName: json['patientName'] as String,
      relationShip: json['relationship'] as String,
      serviceName: json['serviceName'] as String,
      servicePrice: json['servicePrice'] as double,
    );
  }
}
