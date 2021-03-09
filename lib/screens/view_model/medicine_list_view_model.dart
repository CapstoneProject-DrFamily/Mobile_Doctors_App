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
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_detail_form.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_search_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class MedicineListViewModel extends BaseModel {
  final IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();

  static bool isUpdate = false;
  static List<MedicineDetailModel> listMedicine = [];

  TextEditingController _noteController = TextEditingController();
  TextEditingController get notecontroller => _noteController;

  bool keyboard = false;

  DatabaseReference _transactionRequest;

  MedicineListViewModel() {
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");
    initMedicineList();
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
        transactionId: "TS-bdab3709-f484-4067-94de-cb53a28d1ee8",
        doctorId: 14,
        patientId: 20,
        estimatedTime: "14:9 - 14:24",
        examId: 9,
        location: "latitude: 10.7739452, longitude: 106.66849769999999",
        note: "nothing",
        prescriptionId: prescriptionId,
        status: 3);

    bool statusUpdate = await _transactionRepo.updateTransaction(transaction);

    if (statusUpdate == true) {
      _transactionRequest
          .child("TS-4b190c72-a679-4d8f-90f7-b5de8b882d4d")
          .update({
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
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LandingScreen()),
          (Route<dynamic> route) => false);
    }
  }
}
