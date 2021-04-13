import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/model/feedback/feedback_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/examination_history_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/form_parameter_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/patient_transaction_model.dart';
import 'package:mobile_doctors_apps/model/profile/profile_model.dart';
import 'package:mobile_doctors_apps/model/service/service_model.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class TransactionBaseViewModel extends BaseModel {
  ITransactionRepo _transactionRepo = TransactionRepo();
  String transactionId;
  bool init = true;
  PatientTransactionModel patientTransaction;
  ProfileModel profilePatient;
  ProfileModel profileDoctor;

  String doctorSpeciality = '';
  ServiceModel service;
  ExaminationHistoryModel examinationForm;
  FeedbackModel feedback;

  List<String> listCheck = List();

  List<String> diagnoseList = [];

  int inList = 0;

  List<String> listTransaction;

  List<FormParameterModel> listSpeciality = [
    FormParameterModel(name: 'Cardiovascular', description: ""),
    FormParameterModel(name: 'Respiratory', description: ""),
    FormParameterModel(name: 'Gastroenterology', description: ""),
    FormParameterModel(name: 'Nephrology', description: ""),
    FormParameterModel(name: 'Rheumatology', description: ""),
    FormParameterModel(name: 'Endocrine', description: ""),
    FormParameterModel(name: 'Nerve', description: ""),
    FormParameterModel(name: 'Mental', description: ""),
    FormParameterModel(name: 'Surgery', description: ""),
    FormParameterModel(name: 'Obstetrics & Gynecology', description: ""),
    FormParameterModel(name: 'Otorhinolaryngology', description: ""),
    FormParameterModel(name: 'Odonto-Stomatology', description: ""),
    FormParameterModel(name: 'Ophthalmology', description: ""),
    FormParameterModel(name: 'Dermatology', description: ""),
    FormParameterModel(name: 'Nutrition', description: ""),
    FormParameterModel(name: 'Activity', description: ""),
    // Speciality(name: 'Khác', description: ""),
    FormParameterModel(name: 'Evaluation', description: ""),
  ];

  Future<void> fetchData(String transactionId) async {
    if (init) {
      List<dynamic> results =
          await _transactionRepo.getTransactionPatientDetail(transactionId);
      patientTransaction = results[0];
      profilePatient = results[1];
      doctorSpeciality = results[2];
      service = results[3];
      examinationForm = results[4];
      feedback = results[5];
      profileDoctor = results[6];

      diagnoseList = examinationForm.conclusion.split(";");

      initCheck(this.listCheck);
      this.init = false;

      notifyListeners();
    }
  }

  double getFieldNumber(String field) {
    switch (field) {
      case 'pulseRate':
        return this.examinationForm.pulseRate;
        break;
      case 'temperature':
        return this.examinationForm.temperature;
        break;
      case 'respiratoryRate':
        return this.examinationForm.respiratoryRate;
        break;
      case 'weight':
        return this.examinationForm.weight;
        break;
      case 'height':
        return this.examinationForm.height;
        break;
      case 'waistCircumference':
        return this.examinationForm.waistCircumference;
        break;
      case 'rightEye':
        return this.examinationForm.rightEye;
        break;
      case 'leftEye':
        return this.examinationForm.leftEye;
        break;
      case 'rightEyeGlassed':
        return this.examinationForm.rightEyeGlassed;
        break;
      case 'leftEyeGlassed':
        return this.examinationForm.leftEyeGlassed;
        break;
      case 'BMI':
        if (this.examinationForm.height == null ||
            this.examinationForm.height == 0) {
          break;
        }
        double height = this.examinationForm.height / 100;
        print(height);
        return (this.examinationForm.weight / (height * height));
        break;
    }
  }

  void initCheck(List listCheck) {
    if (this.examinationForm.cardiovascular != null) {
      listCheck.add(this.listSpeciality[0].name);
    }
    if (this.examinationForm.respiratory != null) {
      listCheck.add(this.listSpeciality[1].name);
    }
    if (this.examinationForm.gastroenterology != null) {
      listCheck.add(this.listSpeciality[2].name);
    }

    if (this.examinationForm.nephrology != null) {
      listCheck.add(this.listSpeciality[3].name);
    }

    if (this.examinationForm.rheumatology != null) {
      listCheck.add(this.listSpeciality[4].name);
    }
    if (this.examinationForm.endocrine != null) {
      listCheck.add(this.listSpeciality[5].name);
    }
    if (this.examinationForm.nerve != null) {
      listCheck.add(this.listSpeciality[6].name);
    }
    if (this.examinationForm.mental != null) {
      listCheck.add(this.listSpeciality[7].name);
    }
    if (this.examinationForm.surgery != null) {
      listCheck.add(this.listSpeciality[8].name);
    }
    if (this.examinationForm.obstetricsGynecology != null) {
      listCheck.add(this.listSpeciality[9].name);
    }
    if (this.examinationForm.otorhinolaryngology != null) {
      listCheck.add(this.listSpeciality[10].name);
    }
    if (this.examinationForm.odontoStomatology != null) {
      listCheck.add(this.listSpeciality[11].name);
    }
    if (this.examinationForm.ophthalmology != null) {
      listCheck.add(this.listSpeciality[12].name);
    }
    if (this.examinationForm.dermatology != null) {
      listCheck.add(this.listSpeciality[13].name);
    }
    if (this.examinationForm.nutrition != null) {
      listCheck.add(this.listSpeciality[14].name);
    }
    if (this.examinationForm.activity != null) {
      listCheck.add(this.listSpeciality[15].name);
    }
    if (this.examinationForm.evaluation != null) {
      listCheck.add(this.listSpeciality[16].name);
    }
  }

  String getTextData(
    int index,
  ) {
    switch (index) {
      case 0:
        return this.examinationForm.cardiovascular;
        break;
      case 1:
        return this.examinationForm.respiratory;
        break;
      case 2:
        return this.examinationForm.gastroenterology;
        break;
      case 3:
        return this.examinationForm.nephrology;
        break;
      case 4:
        return this.examinationForm.rheumatology;
        break;
      case 5:
        return this.examinationForm.endocrine;
        break;
      case 6:
        return this.examinationForm.nerve;
        break;
      case 7:
        return this.examinationForm.mental;
        break;
      case 8:
        return this.examinationForm.surgery;
        break;
      case 9:
        return this.examinationForm.obstetricsGynecology;
        break;
      case 10:
        return this.examinationForm.otorhinolaryngology;
        break;
      case 11:
        return this.examinationForm.odontoStomatology;
        break;
      case 12:
        return this.examinationForm.ophthalmology;
        break;
      case 13:
        return this.examinationForm.dermatology;
        break;
      case 14:
        return this.examinationForm.nutrition;
        break;
      case 15:
        return this.examinationForm.activity;
        break;
      case 16:
        return this.examinationForm.evaluation;
        break;
    }
  }

  void nextTransaction(BuildContext context) async {
    waitDialog(context, message: "Getting newest record");

    inList = inList - 1;
    List<dynamic> results = await _transactionRepo
        .getTransactionPatientDetail(listTransaction[inList]);
    patientTransaction = results[0];
    profilePatient = results[1];
    doctorSpeciality = results[2];
    service = results[3];
    examinationForm = results[4];
    feedback = results[5];
    profileDoctor = results[6];

    initCheck(this.listCheck);
    Navigator.pop(context);
    notifyListeners();
  }

  void previousTransaction(BuildContext context) async {
    waitDialog(context, message: "Getting previous record");
    inList = inList + 1;
    List<dynamic> results = await _transactionRepo
        .getTransactionPatientDetail(listTransaction[inList]);
    patientTransaction = results[0];
    profilePatient = results[1];
    doctorSpeciality = results[2];
    service = results[3];
    examinationForm = results[4];
    feedback = results[5];
    profileDoctor = results[6];

    initCheck(this.listCheck);
    Navigator.pop(context);
    notifyListeners();
  }
}
