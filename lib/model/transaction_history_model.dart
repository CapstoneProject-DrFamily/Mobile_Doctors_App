class TransactionHistoryModel {
  final String serviceName, location, transactionID, patientName, dateTimeStart;
  final int status;
  final double servicePrice;
  TransactionHistoryModel(
      {this.dateTimeStart,
      this.patientName,
      this.location,
      this.serviceName,
      this.servicePrice,
      this.status,
      this.transactionID});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      transactionID: json['transactionId'] as String,
      dateTimeStart: json['dateStart'] as String,
      status: json['status'] as int,
      servicePrice: json['servicePrice'] as double,
      patientName: json['patientName'] as String,
      serviceName: json['serviceName'] as String,
      location: json['location'] as String,
    );
  }
}
