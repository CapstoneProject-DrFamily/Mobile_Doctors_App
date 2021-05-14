class PatientModel {
  String patientName,
      patientImage,
      patientDOB,
      patientGender,
      patientPhone,
      patientBloodType,
      patientRelationShip;
  double patientHeight, patientWeight;
  PatientModel(
      {this.patientBloodType,
      this.patientDOB,
      this.patientGender,
      this.patientHeight,
      this.patientImage,
      this.patientName,
      this.patientPhone,
      this.patientWeight,
      this.patientRelationShip});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      patientName: json['fullname'] as String,
      patientBloodType: json['bloodType'] as String,
      patientDOB: json['birthday'] as String,
      patientGender: json['gender'] as String,
      patientHeight: json['height'] as double,
      patientImage: json['image'] as String,
      patientPhone: json['phone'] as String,
      patientWeight: json['weight'] as double,
      patientRelationShip: json['relationship'] as String,
    );
  }
}
