class TransactionBasicModel {
  final String transactionId,
      patientName,
      patientImage,
      locationName,
      symptomName,
      patientNote,
      location;
  final double distance, longitude, latitude;
  final int endTime, doctorId, patientId;
  final List<SymptomTempModel> patientSymptom;
  String estimateTime;
  int examId;

  TransactionBasicModel({
    this.distance,
    this.locationName,
    this.patientName,
    this.symptomName,
    this.transactionId,
    this.endTime,
    this.latitude,
    this.longitude,
    this.patientImage,
    this.patientNote,
    this.patientSymptom,
    this.doctorId,
    this.location,
    this.patientId,
  });

  factory TransactionBasicModel.fromJson(Map<String, dynamic> json) {
    return TransactionBasicModel(
      transactionId: json['transactionId'] as String,
      patientName: json['patientName'] as String,
      patientImage: json['patientImage'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      patientNote: json['patientNote'] as String,
      patientSymptom: json['patientSymptom'],
      locationName: json['locationName'] as String,
      distance: json['distance'] as double,
      endTime: json['endTime'] as int,
      symptomName: json['symptomName'] as String,
      doctorId: json['doctorId'] as int,
      location: json['location'] as String,
      patientId: json['patientId'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'transactionId': transactionId,
        'patientName': patientName,
        'patientImage': patientImage,
        'latitude': latitude,
        'longitude': longitude,
        'patientNote': patientNote,
        'patientSymptom': patientSymptom,
        'locationName': locationName,
        'distance': distance,
        'endTime': endTime,
        'symptomName': symptomName,
        'doctorId': doctorId,
        'location': location,
        'patientId': patientId,
      };
}

class SymptomTempModel {
  final String symptomName, symptomtype;

  SymptomTempModel({this.symptomName, this.symptomtype});

  factory SymptomTempModel.fromJson(Map<String, dynamic> json) {
    return SymptomTempModel(
      symptomName: json['symptom']['name'] as String,
      symptomtype: json['symptom']['type'] as String,
    );
  }
}
