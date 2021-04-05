import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/enums/processState.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/model/specialty_model.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyzePageViewModel extends BaseModel {
  String transactionId;
  ExaminationHistory examinationForm = ExaminationHistory();
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  var BMIController = TextEditingController();
  bool isLoading = false;
  bool init = true;
  double BMI = 0;

  String _exam_id;

  List<Speciality> listSpeciality = [
    Speciality(name: 'Cardiovascular', description: ""),
    Speciality(name: 'Respiratory', description: ""),
    Speciality(name: 'Gastroenterology', description: ""),
    Speciality(name: 'Nephrology', description: ""),
    Speciality(name: 'Rheumatology', description: ""),
    Speciality(name: 'Endocrine', description: ""),
    Speciality(name: 'Nerve', description: ""),
    Speciality(name: 'Mental', description: ""),
    Speciality(name: 'Surgery', description: ""),
    Speciality(name: 'Obstetrics & Gynecology', description: ""),
    Speciality(name: 'Otorhinolaryngology', description: ""),
    Speciality(name: 'Odonto-Stomatology', description: ""),
    Speciality(name: 'Ophthalmology', description: ""),
    Speciality(name: 'Dermatology', description: ""),
    Speciality(name: 'Nutrition', description: ""),
    Speciality(name: 'Activity', description: ""),
    // Speciality(name: 'Khác', description: ""),
    Speciality(name: 'Evaluation', description: ""),
  ];

  DatabaseReference _transactionRequest;

  bool keyboard = false;

  AnalyzePageViewModel() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print("visible : " + visible.toString());
        this.keyboard = visible;
      },
    );
  }

  Future<void> fetchData(
      String transactionId, TimeLineViewModel model, List listCheck) async {
    if (this.init) {
      print('analyze $transactionId');
      this.transactionId = transactionId;
      _exam_id = transactionId;

      if (model.currentIndex < model.index) {
        _transactionRequest =
            FirebaseDatabase.instance.reference().child("Transaction");

        _exam_id = transactionId;

        examinationForm =
            await _examinationRepo.getExaminationHistory(_exam_id);

        if (this.examinationForm.height != 0 &&
            this.examinationForm.height != null &&
            this.examinationForm.weight != null) {
          double height = this.examinationForm.height / 100;
          this.BMI = this.examinationForm.weight / (height * height);
          BMIController.text = this.BMI.toStringAsFixed(1);
        } else {
          BMIController.text = this.BMI.toStringAsFixed(1);
        }

        initCheck(listCheck);
      }
      this.init = false;
      notifyListeners();
    }
  }

  void resetField(String field, AnalyzePageViewModel model) {
    switch (field) {
      case 'pulseRate':
        model.examinationForm.pulseRate = null;
        break;
      case 'temperature':
        model.examinationForm.temperature = null;
        break;
      case 'bloodPressure':
        model.examinationForm.bloodPressure = null;
        break;
      case 'respiratoryRate':
        model.examinationForm.respiratoryRate = null;
        break;
      case 'weight':
        model.examinationForm.weight = null;
        break;
      case 'height':
        model.examinationForm.height = null;
        break;
      case 'waistCircumference':
        model.examinationForm.waistCircumference = null;
        break;
    }
  }

  void changeFieldText(int index, AnalyzePageViewModel model, String value) {
    switch (index) {
      case 0:
        model.examinationForm.cardiovascular = value;
        break;
      case 1:
        model.examinationForm.respiratory = value;
        break;
      case 2:
        model.examinationForm.gastroenterology = value;
        break;
      case 3:
        model.examinationForm.nephrology = value;
        break;
      case 4:
        model.examinationForm.rheumatology = value;
        break;
      case 5:
        model.examinationForm.endocrine = value;
        break;
      case 6:
        model.examinationForm.nerve = value;
        break;
      case 7:
        model.examinationForm.mental = value;
        break;
      case 8:
        model.examinationForm.surgery = value;
        break;
      case 9:
        model.examinationForm.obstetricsGynecology = value;
        break;
      case 10:
        model.examinationForm.otorhinolaryngology = value;
        break;
      case 11:
        model.examinationForm.odontoStomatology = value;
        break;
      case 12:
        model.examinationForm.ophthalmology = value;
        break;
      case 13:
        model.examinationForm.dermatology = value;
        break;
      case 14:
        model.examinationForm.nutrition = value;
        break;
      case 15:
        model.examinationForm.activity = value;
        break;
      case 16:
        model.examinationForm.evaluation = value;
        break;
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

  void changeFieldNumber(
      String field, AnalyzePageViewModel model, String value) {
    var num;
    try {
      num = double.parse(value);
    } catch (e) {
      resetField(field, model);
      return;
    }

    switch (field) {
      case 'pulseRate':
        model.examinationForm.pulseRate = num;
        break;
      case 'temperature':
        model.examinationForm.temperature = num;
        break;
      case 'bloodPressure':
        model.examinationForm.bloodPressure = num;
        break;
      case 'respiratoryRate':
        model.examinationForm.respiratoryRate = num;
        break;
      case 'weight':
        model.examinationForm.weight = num;
        break;
      case 'height':
        model.examinationForm.height = num;
        if (model.examinationForm.height != 0 &&
            model.examinationForm.height != null &&
            model.examinationForm.weight != null) {
          double height = this.examinationForm.height / 100;
          this.BMI = this.examinationForm.weight / (height * height);
          BMIController.text = this.BMI.toStringAsFixed(1);
        }

        break;
      case 'waistCircumference':
        model.examinationForm.waistCircumference = num;
        break;
      case 'rightEye':
        model.examinationForm.rightEye = num;
        break;
      case 'leftEye':
        model.examinationForm.leftEye = num;
        break;
      case 'rightEyeGlassed':
        model.examinationForm.rightEyeGlassed = num;
        break;
      case 'leftEyeGlassed':
        model.examinationForm.leftEyeGlassed = num;
        break;
    }

    notifyListeners();
  }

  double getFieldNumber(String field) {
    switch (field) {
      case 'pulseRate':
        return this.examinationForm.pulseRate;
        break;
      case 'temperature':
        return this.examinationForm.temperature;
        break;
      case 'bloodPressure':
        return this.examinationForm.bloodPressure;
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
        return this.BMI;

        break;
    }
  }

  // List<String> listCheck = List();

  bool change = false;

  void changed(bool value) {
    this.change = value;
    notifyListeners();
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

  void changeCheck(String name, bool isCheck, List listCheck, int index,
      AnalyzePageViewModel model) {
    if (isCheck) {
      if (!listCheck.contains(name)) {
        listCheck.add(name);
      }
    } else {
      clearInput(index, model);
      listCheck.remove(name);
    }
    notifyListeners();
  }

  Future<bool> createExaminationForm(
      String transactionId, TimeLineViewModel timelineModel) async {
    isLoading = true;
    notifyListeners();
    // mock
    // transactionId = "TS-1387c26f-f89a-43e7-a907-e7d20aff2542";

    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    print('transactionId: $transactionId $_exam_id');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String creator = prefs.getString("usName");

    // mock
    // String creator = "khoa";

    examinationForm.id = _exam_id;
    examinationForm.updBy = creator;
    examinationForm.insBy = creator;

    bool isSuccess = await _examinationRepo
        .updateExaminationHistory(jsonEncode(examinationForm));

    if (isSuccess && timelineModel.currentIndex == timelineModel.index) {
      _transactionRequest = FirebaseDatabase.instance
          .reference()
          .child("Transaction")
          .child(transactionId);

      _transactionRequest.update({"transaction_status": "Take Sample"});
      timelineModel.index = ProcessState.SAMPLE;
    }
    isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  void clearInput(int index, AnalyzePageViewModel model) {
    switch (index) {
      case 0:
        model.examinationForm.cardiovascular = null;
        break;
      case 1:
        model.examinationForm.respiratory = null;
        break;
      case 2:
        model.examinationForm.gastroenterology = null;
        break;
      case 3:
        model.examinationForm.nephrology = null;
        break;
      case 4:
        model.examinationForm.rheumatology = null;
        break;
      case 5:
        model.examinationForm.endocrine = null;
        break;
      case 6:
        model.examinationForm.nerve = null;
        break;
      case 7:
        model.examinationForm.mental = null;
        break;
      case 8:
        model.examinationForm.surgery = null;
        break;
      case 9:
        model.examinationForm.obstetricsGynecology = null;
        break;
      case 10:
        model.examinationForm.otorhinolaryngology = null;
        break;
      case 11:
        model.examinationForm.odontoStomatology = null;
        break;
      case 12:
        model.examinationForm.ophthalmology = null;
        break;
      case 13:
        model.examinationForm.dermatology = null;
        break;
      case 14:
        model.examinationForm.nutrition = null;
        break;
      case 15:
        model.examinationForm.activity = null;
        break;
      case 16:
        model.examinationForm.evaluation = null;
        break;
    }
  }
}
