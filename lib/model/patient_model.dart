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
      patientName: json['patientNavigation']['fullName'] as String,
      patientBloodType: json['bloodType'] as String,
      patientDOB: json['patientNavigation']['birthday'] as String,
      patientGender: json['patientNavigation']['gender'] as String,
      patientHeight: json['height'] as double,
      patientImage: json['patientNavigation']['image'] as String,
      patientPhone: json['patientNavigation']['phone'] as String,
      patientWeight: json['weight'] as double,
      patientRelationShip: json['relationship'] as String,
    );
  }
}
