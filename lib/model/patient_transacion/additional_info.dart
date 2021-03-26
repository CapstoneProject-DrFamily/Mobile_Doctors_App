class AdditionInfoModel {
  String bloodType, relationship, updBy, updDatetime;
  double height, weight;
  int patientId;

  AdditionInfoModel(
      {this.patientId,
      this.bloodType,
      this.height,
      this.weight,
      this.updBy,
      this.updDatetime,
      this.relationship});

  factory AdditionInfoModel.fromJson(Map<String, dynamic> json) {
    return AdditionInfoModel(
      patientId: json['patientId'] as int,
      bloodType: json['bloodType'] as String,
      height: json['height'] as double,
      weight: json['weight'] as double,
      updBy: json['updBy'] as String,
      updDatetime: json['updDatetime'] as String,
      relationship: json['relationship'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "patientId": patientId,
        "height": height,
        "weight": weight,
        "bloodType": bloodType,
        "relationship": relationship,
      };
}
