class TransactionBasicModel {
  final String transactionId, patientName, locationName, symptomName;
  final double distance;
  final int endTime;

  TransactionBasicModel({
    this.distance,
    this.locationName,
    this.patientName,
    this.symptomName,
    this.transactionId,
    this.endTime,
  });

  factory TransactionBasicModel.fromJson(Map<String, dynamic> json) {
    return TransactionBasicModel(
      transactionId: json['transactionId'] as String,
      patientName: json['patientName'] as String,
      locationName: json['locationName'] as String,
      distance: json['distance'] as double,
      endTime: json['endTime'] as int,
      symptomName: json['symptomName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'patientName': patientName,
        'locationName': locationName,
        'distance': distance,
        'endTime': endTime,
        'symptomName': symptomName,
      };
}

class SymptomTempModel {
  final String symptomName;

  SymptomTempModel({this.symptomName});

  factory SymptomTempModel.fromJson(Map<String, dynamic> json) {
    return SymptomTempModel(
      symptomName: json['symptom']['name'] as String,
    );
  }
}
