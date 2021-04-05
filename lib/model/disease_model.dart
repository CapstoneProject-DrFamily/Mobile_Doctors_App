class DiseaseModel {
  final String diseaseCode,
      chapterCode,
      chapterName,
      mainGroupCode,
      mainGroupName,
      typeCode,
      typeName,
      diseaseName;
  DiseaseModel(
      {this.chapterCode,
      this.chapterName,
      this.diseaseCode,
      this.diseaseName,
      this.mainGroupCode,
      this.mainGroupName,
      this.typeCode,
      this.typeName});

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      diseaseCode: json['diseaseCode'] as String,
      chapterCode: json['chapterCode'] as String,
      chapterName: json['chapterName'] as String,
      mainGroupCode: json['mainGroupCode'] as String,
      mainGroupName: json['mainGroupName'] as String,
      typeCode: json['typeCode'] as String,
      typeName: json['typeName'] as String,
      diseaseName: json['diseaseName'] as String,
    );
  }
}

class PagingDiseaseModel {
  List<DiseaseModel> listDisease;
  bool hasNextPage;

  PagingDiseaseModel({this.hasNextPage, this.listDisease});
}
