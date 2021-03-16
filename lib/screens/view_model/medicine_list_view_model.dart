import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/model/prescription_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/prescription_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/history/transaction_detail_page.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_detail_form.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_search_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class MedicineListViewModel extends BaseModel {
  final IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  bool init = true;

  static bool isUpdate = false;
  static List<MedicineDetailModel> listMedicine = [];

  TextEditingController _noteController = TextEditingController();
  TextEditingController get notecontroller => _noteController;

  bool keyboard = false;

  DatabaseReference _transactionRequest;

  String transactionId, estimateTime, location, note;
  int doctorId, examId, patientId;

  MedicineListViewModel() {
    isUpdate = false;
    listMedicine = [];
    initMedicineList();
  }

  fetchData(transactionId) {
    if (init) {
      this.transactionId = transactionId;
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
    isUpdate = false;
    listMedicine = [];
    PrescriptionModel prescriptionModel = new PrescriptionModel(
        prescriptionDes: _noteController.text,
        insBy: "H.Duc",
        updateBy: "H.Duc",
        listMedicine: listMedicine);

    String prescriptionJson = jsonEncode(prescriptionModel.toJson());

    print(prescriptionJson);

    int prescriptionId =
        await _prescriptionRepo.createPrescription(prescriptionJson);

    Transaction transaction = new Transaction(
        transactionId: transactionId,
        doctorId: doctorId,
        patientId: patientId,
        estimatedTime: estimateTime,
        examId: examId,
        location: location,
        note: note,
        prescriptionId: prescriptionId,
        status: 3);

    bool statusUpdate = await _transactionRepo.updateTransaction(transaction);

    if (statusUpdate == true) {
      _transactionRequest.child(transactionId).update({
        "transaction_status": "done",
        "rating": false,
      });

      Fluttertoast.showToast(
        msg: "Your have done this transaction",
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TransactionDetailPage(transactionId: transactionId),
        ),
      );
    }
  }
}
