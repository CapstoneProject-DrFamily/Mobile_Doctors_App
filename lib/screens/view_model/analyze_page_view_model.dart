import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/model/specialty_model.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyzePageViewModel extends BaseModel {
  String transactionId;
  ExaminationHistory examinationForm;
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  bool isLoading = false;
  bool init = true;

  List<Speciality> listSpeciality = [
    Speciality(name: 'Tim mạch', description: ""),
    Speciality(name: 'Hô hấp', description: ""),
    Speciality(name: 'Tiêu hóa', description: ""),
    Speciality(name: 'Tiết niệu', description: ""),
    Speciality(name: 'Cơ xương khớp', description: ""),
    Speciality(name: 'Nội tiết', description: ""),
    Speciality(name: 'Thần kinh', description: ""),
    Speciality(name: 'Tâm thần', description: ""),
    Speciality(name: 'Ngoại khoa', description: ""),
    Speciality(name: 'Sản phụ khoa', description: ""),
    Speciality(name: 'Tai mũi họng', description: ""),
    Speciality(name: 'Răng hàm mặt', description: ""),
    Speciality(name: 'Mắt', description: ""),
    Speciality(name: 'Da liễu', description: ""),
    Speciality(name: 'Dinh dưỡng', description: ""),
    Speciality(name: 'Vận động', description: ""),
    // Speciality(name: 'Khác', description: ""),
    Speciality(
        name: 'Đánh giá phát triển thể chất, tinh thần, vận động',
        description: ""),
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

    examinationForm = new ExaminationHistory();
  }

  fetchData(transactionId) {
    if (init) {
      this.transactionId = transactionId;
      init = false;
      print("load transaction");
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
  }

  // List<String> listCheck = List();

  bool change = false;

  void changed(bool value) {
    this.change = value;
    notifyListeners();
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

  Future<bool> createExaminationForm(String transactionId) async {
    isLoading = true;
    notifyListeners();
    // mock
    // transactionId = "TS-4b190c72-a679-4d8f-90f7-b5de8b882d4d";

    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");
    int exam_id;
    await _transactionRequest
        .child(transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        exam_id = dataSnapshot.value['exam_id'];
      }
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String creator = prefs.getString("usName");

    // mock
    // String creator = "khoa";

    examinationForm.id = exam_id;
    examinationForm.updBy = creator;
    examinationForm.insBy = creator;

    bool isSuccess = await _examinationRepo
        .updateExaminationHistory(jsonEncode(examinationForm));

    if (isSuccess) {
      _transactionRequest = FirebaseDatabase.instance
          .reference()
          .child("Transaction")
          .child(transactionId);

      _transactionRequest.update({"transaction_status": "Take Sample"});
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
