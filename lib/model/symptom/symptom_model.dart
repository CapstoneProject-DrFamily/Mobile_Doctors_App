class SymptomModel {
  int symptomId;
  String symptomName, symptomDes, symptomType;

  SymptomModel(
      {this.symptomDes, this.symptomId, this.symptomName, this.symptomType});

  factory SymptomModel.fromJson(Map<String, dynamic> json) {
    return SymptomModel(
      symptomId: json['symptomId'] as int,
      symptomName: json['name'] as String,
      symptomDes: json['description'] as String,
      symptomType: json['type'] as String,
    );
  }
}

class SymtomModel {
  String headerValue;
  Map<int, String> expandedValue;

  SymtomModel({this.expandedValue, this.headerValue});
}
