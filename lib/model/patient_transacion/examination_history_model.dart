class ExaminationHistoryModel {
  String id,
      history,
      mucosa,
      otherBody,
      cardiovascular,
      respiratory,
      gastroenterology,
      nephrology,
      rheumatology,
      endocrine,
      nerve,
      mental,
      surgery,
      obstetricsGynecology,
      otorhinolaryngology,
      odontoStomatology,
      ophthalmology,
      dermatology,
      nutrition,
      activity,
      evaluation,
      hematology,
      bloodChemistry,
      urineBiochemistry,
      abdominalUltrasound,
      conclusion,
      bloodPressure,
      advisory;

  String insBy, updBy;

  double pulseRate,
      temperature,
      respiratoryRate,
      weight,
      height,
      waistCircumference,
      rightEye,
      leftEye,
      rightEyeGlassed,
      leftEyeGlassed;

  ExaminationHistoryModel({
    this.id,
    this.history,
    this.pulseRate,
    this.temperature,
    this.bloodPressure,
    this.respiratoryRate,
    this.weight,
    this.height,
    this.waistCircumference,
    this.rightEye,
    this.leftEye,
    this.rightEyeGlassed,
    this.leftEyeGlassed,
    this.mucosa,
    this.otherBody,
    this.cardiovascular,
    this.respiratory,
    this.gastroenterology,
    this.nephrology,
    this.rheumatology,
    this.endocrine,
    this.nerve,
    this.mental,
    this.surgery,
    this.obstetricsGynecology,
    this.otorhinolaryngology,
    this.odontoStomatology,
    this.ophthalmology,
    this.dermatology,
    this.nutrition,
    this.activity,
    this.evaluation,
    this.hematology,
    this.bloodChemistry,
    this.urineBiochemistry,
    this.abdominalUltrasound,
    this.conclusion,
    this.advisory,
    this.insBy,
    this.updBy,
  });

  factory ExaminationHistoryModel.fromJson(Map<String, dynamic> json) {
    return ExaminationHistoryModel(
      id: json['id'] as String,
      history: json['history'] as String,
      pulseRate: json['pulseRate'] as double,
      temperature: json['temperature'] as double,
      bloodPressure: json['bloodPressure'] as String,
      respiratoryRate: json['respiratoryRate'] as double,
      weight: json['weight'] as double,
      height: json['height'] as double,
      waistCircumference: json['waistCircumference'] as double,
      rightEye: json['rightEye'] as double,
      leftEye: json['leftEye'] as double,
      rightEyeGlassed: json['rightEyeGlassed'] as double,
      leftEyeGlassed: json['leftEyeGlassed'] as double,
      mucosa: json['mucosa'] as String,
      otherBody: json['otherBody'] as String,
      cardiovascular: json['cardiovascular'] as String,
      respiratory: json['respiratory'] as String,
      gastroenterology: json['gastroenterology'] as String,
      nephrology: json['nephrology'] as String,
      rheumatology: json['rheumatology'] as String,
      endocrine: json['endocrine'] as String,
      nerve: json['nerve'] as String,
      mental: json['mental'] as String,
      surgery: json['surgery'] as String,
      obstetricsGynecology: json['obstetricsGynecology'] as String,
      otorhinolaryngology: json['otorhinolaryngology'] as String,
      odontoStomatology: json['odontoStomatology'] as String,
      ophthalmology: json['ophthalmology'] as String,
      dermatology: json['dermatology'] as String,
      nutrition: json['nutrition'] as String,
      activity: json['activity'] as String,
      evaluation: json['evaluation'] as String,
      bloodChemistry: json['bloodTest'] as String,
      urineBiochemistry: json['urineTest'] as String,
      conclusion: json['conclusion'] as String,
      advisory: json['advisory'] as String,
      insBy: json['insBy'] as String,
      updBy: json['updBy'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "history": history,
        "pulseRate": pulseRate,
        "temperature": temperature,
        "bloodPressure": bloodPressure,
        "respiratoryRate": respiratoryRate,
        "weight": weight,
        "height": height,
        "waistCircumference": waistCircumference,
        "rightEye": rightEye,
        "leftEye": leftEye,
        "rightEyeGlassed": rightEyeGlassed,
        "leftEyeGlassed": leftEyeGlassed,
        "mucosa": mucosa,
        "otherBody": otherBody,
        "cardiovascular": cardiovascular,
        "respiratory": respiratory,
        "gastroenterology": gastroenterology,
        "nephrology": nephrology,
        "rheumatology": rheumatology,
        "endocrine": endocrine,
        "nerve": nerve,
        "mental": mental,
        "surgery": surgery,
        "obstetricsGynecology": obstetricsGynecology,
        "otorhinolaryngology": otorhinolaryngology,
        "odontoStomatology": odontoStomatology,
        "ophthalmology": ophthalmology,
        "dermatology": dermatology,
        "nutrition": nutrition,
        "activity": activity,
        "evaluation": evaluation,
        "hematology": hematology,
        "bloodTest": bloodChemistry,
        "urineTest": urineBiochemistry,
        "abdominalUltrasound": abdominalUltrasound,
        "conclusion": conclusion,
        "advisory": advisory,
        "insBy": insBy,
        "updBy": updBy,
      };
}
