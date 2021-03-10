import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class DiagnosePageViewModel extends BaseModel {
  final IExaminationRepo _examinationRepo = ExaminationRepo();

  bool keyboard = false;
  int examId;
  String transactionId;
  bool init = true;

  ExaminationHistory _examinationHistory;
  ExaminationHistory get examinationHistory => _examinationHistory;

  TextEditingController _diagnoseConclusionController = TextEditingController();
  TextEditingController get diagnoseConclusionController =>
      _diagnoseConclusionController;

  TextEditingController _doctorAdviceController = TextEditingController();
  TextEditingController get doctorAdviceController => _doctorAdviceController;

  DatabaseReference _transactionRequest;

  DiagnosePageViewModel() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboard = visible;
      },
    );
  }

  void initDiagnose() async {
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _transactionRequest
        .child(transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        examId = dataSnapshot.value['exam_id'];
      }
    });
    _examinationHistory = await _examinationRepo.getExaminationHistory(examId);
  }

  fetchData(transactionId) {
    if (init) {
      this.transactionId = transactionId;
      init = false;
      print("load transaction");
      initDiagnose();
    }
  }

  Future<void> confirmDiagnose() async {
    print(
        'conclusion: ${_diagnoseConclusionController.text}, advice: ${_doctorAdviceController.text}');

    _examinationHistory.conclusion = _diagnoseConclusionController.text;
    _examinationHistory.advisory = _doctorAdviceController.text;

    String jsonExaminationHistory = jsonEncode(_examinationHistory);

    bool diagnoseStatus =
        await _examinationRepo.updateExaminationHistory(jsonExaminationHistory);
    Map transactionInfo = {
      "transaction_status": "Prescription",
    };

    await _transactionRequest.child(transactionId).set(transactionInfo);

    if (diagnoseStatus) {
      Fluttertoast.showToast(
        msg: "Update Success",
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Something Wrong",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
