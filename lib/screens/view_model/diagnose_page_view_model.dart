import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/enums/processState.dart';
import 'package:mobile_doctors_apps/model/disease_model.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/repository/disease_repo.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';

class DiagnosePageViewModel extends BaseModel {
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  final IDiseaseRepo _diseaseRepo = DiseaseRepo();

  bool keyboard = false;
  String examId;
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

  List<DiseaseModel> _listDiseaseModel = [];
  List<DiseaseModel> get listDiseaseModel => _listDiseaseModel;

  PagingDiseaseModel _pagingDiseaseModel;
  PagingDiseaseModel get pagingDiseaseModel => _pagingDiseaseModel;

  bool hasNextPage;
  bool hasSearchNextPage;

  int _indexListDiagnose = 1;
  int _indexSearchListDiagnose = 1;

  bool _changeList = false;
  bool get changeList => _changeList;

  bool isLoading;

  bool loadingNext = false;

  String _searchValue;

  List<DiseaseModel> _listDiseaseSearchModel = [];
  List<DiseaseModel> get listDiseaseSearchModel => _listDiseaseSearchModel;

  List<DiseaseModel> _listChooseModel = [];
  List<DiseaseModel> get listChooseModel => _listChooseModel;

  DiagnosePageViewModel() {
    _diagnoseConclusionController.addListener(() {
      if (_diagnoseConclusionController.text == "") {
        _changeList = false;
      }
      notifyListeners();
    });
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboard = visible;
      },
    );
  }

  void initDiagnose() async {
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");
    examId = transactionId;

    _examinationHistory = await _examinationRepo.getExaminationHistory(examId);
  }

  fetchData(transactionId, TimeLineViewModel model) async {
    if (init) {
      await Future.delayed(Duration(seconds: 1));
      this.transactionId = transactionId;

      print("load transaction");
      initDiagnose();

      if (model.currentIndex < model.index) {
        _transactionRequest =
            FirebaseDatabase.instance.reference().child("Transaction");

        examId = transactionId;

        _examinationHistory =
            await _examinationRepo.getExaminationHistory(examId);
        _diagnoseConclusionController.text = _examinationHistory.conclusion;
        _doctorAdviceController.text = _examinationHistory.advisory;
      }

      init = false;
      notifyListeners();
    }
  }

  Future<void> confirmDiagnose(
      TimeLineViewModel model, BuildContext context) async {
    loadingNext = true;
    notifyListeners();
    print(
        'conclusion: ${_diagnoseConclusionController.text}, advice: ${_doctorAdviceController.text}');

    _examinationHistory.conclusion = _diagnoseConclusionController.text;
    _examinationHistory.advisory = _doctorAdviceController.text;

    String jsonExaminationHistory = jsonEncode(_examinationHistory);

    bool diagnoseStatus =
        await _examinationRepo.updateExaminationHistory(jsonExaminationHistory);

    if (model.currentIndex == model.index) {
      _transactionRequest = FirebaseDatabase.instance
          .reference()
          .child("Transaction")
          .child(transactionId);

      _transactionRequest.update({"transaction_status": "Prescription"});
      model.index = ProcessState.PRESCRIPTION;
    }

    loadingNext = false;
    notifyListeners();

    if (diagnoseStatus) {
      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Update Record Success",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      await CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "Update Record Fail!",
          backgroundColor: Colors.lightBlue[200],
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
          });
    }
  }

  void initSearch() async {
    isLoading = true;
    _pagingDiseaseModel =
        await _diseaseRepo.getPagingDisease(_indexListDiagnose, 20, null);
    if (_pagingDiseaseModel == null) {
      _listDiseaseModel = [];
      notifyListeners();
      return;
    } else {
      _listDiseaseModel = _pagingDiseaseModel.listDisease;
      hasNextPage = _pagingDiseaseModel.hasNextPage;

      isLoading = false;
      notifyListeners();
    }
  }

  void searchDiagnoseFunc(String value) async {
    if (value.length >= 3) {
      _indexSearchListDiagnose = 1;
      // _isNotHave = false;
      isLoading = true;
      _searchValue = value;
      _changeList = true;

      _pagingDiseaseModel = await _diseaseRepo.getPagingDisease(
          _indexSearchListDiagnose, 20, value);
      if (_pagingDiseaseModel == null) {
        _listDiseaseSearchModel = [];
        print("notFound");
        isLoading = false;
        notifyListeners();
        return;
      } else {
        _listDiseaseSearchModel = _pagingDiseaseModel.listDisease;
        hasSearchNextPage = _pagingDiseaseModel.hasNextPage;
        print("listDisease $_listDiseaseSearchModel");
        isLoading = false;
        print("has");

        notifyListeners();
      }
    } else if (value.length == 0) {
      _changeList = false;
      notifyListeners();
    }
  }

  void chooseDisease(DiseaseModel model) {
    print("model $model");
    if (_listChooseModel.length == 0) {
      _listChooseModel.add(model);
    } else {
      for (var item in _listChooseModel) {
        if (item.diseaseCode == model.diseaseCode) {
          print("has Choose");
          //note has choose
        } else {
          _listChooseModel.add(model);
        }
      }
    }
    notifyListeners();
  }

  void changeField() {
    _listDiseaseModel = [];
    _listDiseaseSearchModel = [];
    notifyListeners();
  }
}
