import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/model/medicine_template_model.dart';
import 'package:mobile_doctors_apps/model/prescription_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/appconfig_repo.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/repository/prescription_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/history/transaction_detail_page.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_detail_form.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_search_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineListViewModel extends BaseModel {
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  final IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IAppConfigRepo _appConfigRepo = AppConfigRepo();
  bool init = true;

  static bool isUpdate = false;
  static List<MedicineDetailModel> listMedicine = [];

  TextEditingController _noteController = TextEditingController();
  TextEditingController get notecontroller => _noteController;

  bool keyboard = false;

  DatabaseReference _transactionRequest;

  String transactionId, estimateTime, location, note;
  int doctorId, examId, patientId;

  bool isLoading = false;

  ExaminationHistory _examinationHistory;
  ExaminationHistory get examinationHistory => _examinationHistory;

  List<String> _listChooseModel = [];
  List<String> get listChooseModel => _listChooseModel;

  List<MedicineTemplateModel> _listTemplate = [];

  List<MedicineTemplateModel> _listTemplateDisplay = [];
  List<MedicineTemplateModel> get listTemplateDisplay => _listTemplateDisplay;

  List<DropdownMenuItem<MedicineTemplateModel>> listDropdownMenuItems = [];

  int initTemplate = 0;

  MedicineTemplateModel template;

  bool isNew = false;

  String diseaseId;

  MedicineListViewModel() {
    isUpdate = false;
    listMedicine = [];
    initMedicineList();
  }

  fetchData(transactionId) async {
    if (init) {
      this.transactionId = transactionId;
      _examinationHistory =
          await _examinationRepo.getExaminationHistory(transactionId);
      List<String> slitText = _examinationHistory.conclusion.split(";");

      for (int i = 0; i < slitText.length; i++) {
        _listChooseModel.add(slitText[i].split("-")[0].trim());
      }

      print("list $_listChooseModel");

      _listTemplate = await _appConfigRepo.appConfigPrescriptionTemplate();

      for (var item in _listChooseModel) {
        var itemTemplate = _listTemplate
            .where((element) => element.diseaseId == item)
            .toList();
        _listTemplateDisplay = _listTemplateDisplay + itemTemplate;
      }

      listMedicine = _listTemplateDisplay[initTemplate].listMedicine;

      print(
          "init medicine ${_listTemplateDisplay[initTemplate].listMedicine[0].totalQuantity}");

      print(_listTemplateDisplay.length);

      for (var item in _listTemplateDisplay) {
        print("okle");
        listDropdownMenuItems.add(
          DropdownMenuItem(
            child: Text(
              item.templateName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            value: item,
          ),
        );
      }

      listDropdownMenuItems.add(
        DropdownMenuItem(
          child: Text(
            "Create New",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          value: MedicineTemplateModel(templateName: "Create New"),
        ),
      );

      print("listTest ${listDropdownMenuItems.length}");

      template = _listTemplateDisplay[initTemplate];

      init = false;
      print("load transaction");
      getTransactionFireBase();
    }
  }

  void getTransactionFireBase() async {
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _transactionRequest
        .child(transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        estimateTime = dataSnapshot.value['estimatedTime'];
        location = dataSnapshot.value['location'];
        note = dataSnapshot.value['note'];
        doctorId = dataSnapshot.value['doctor_id'];
        patientId = dataSnapshot.value['patientId'];
        examId = dataSnapshot.value['exam_id'];
      }
    });
  }

  void initMedicineList() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboard = visible;
      },
    );
  }

  void addMedicine(BuildContext context) {
    isUpdate = false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineSearchPage(),
      ),
    ).then((value) {
      notifyListeners();
    });
  }

  void editMedicine(BuildContext context, MedicineDetailModel detailModel) {
    isUpdate = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicineDetailForm(
          detailModel: detailModel,
        ),
      ),
    ).then((value) {
      notifyListeners();
    });
  }

  void finishTransaction(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String doctor = prefs.getString("usName");
    isUpdate = false;
    PrescriptionModel prescriptionModel = new PrescriptionModel(
        prescriptionId: transactionId,
        prescriptionDes:
            (_noteController.text == "") ? null : _noteController.text,
        insBy: doctor,
        updateBy: doctor,
        diseaseId: diseaseId,
        listMedicine: listMedicine);

    String prescriptionJson = jsonEncode(prescriptionModel.toJson());

    print(prescriptionJson);

    await _prescriptionRepo.createPrescription(prescriptionJson);

    Transaction transaction = new Transaction(
        transactionId: transactionId,
        doctorId: doctorId,
        patientId: patientId,
        estimatedTime: estimateTime,
        location: location,
        note: note,
        status: 5);

    bool statusUpdate = await _transactionRepo.updateTransaction(transaction);

    if (statusUpdate == true) {
      listMedicine = [];

      _transactionRequest.child(transactionId).update({
        "transaction_status": "done",
        "rating": false,
      });

      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "You have finish this Record",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailPage(transactionId: transactionId),
            ),
          );
        },
      );
    }
  }

  void onChangeButtom(MedicineTemplateModel model, int index) {
    if (index == -1) {
      isNew = true;
      listMedicine = [];
      template = model;
      diseaseId = null;
    } else {
      isNew = false;
      diseaseId = model.diseaseId;
      template = model;
      initTemplate = index;
      listMedicine = _listTemplateDisplay[initTemplate].listMedicine;
    }
    notifyListeners();
  }

  void deleteMedicine(int medicineID) {
    listMedicine.removeWhere((element) => element.medicineId == medicineID);
    notifyListeners();
  }
}
