import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/record/diagnose_page.dart';
import 'package:mobile_doctors_apps/screens/record/sample_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class TimeLineViewModel extends BaseModel {
  int index = 0;

  DatabaseReference _transactionRequest;

  changeIndex(value) {
    this.index = value;
    notifyListeners();
  }

  Future<void> skipTransaction(String transactionId) async {
    _transactionRequest = FirebaseDatabase.instance
        .reference()
        .child("Transaction")
        .child(transactionId);

    await _transactionRequest.update({"transaction_status": "Diagnose"});
  }

  Widget buildWidget(index, TimeLineViewModel model, transactionId) {
    switch (index) {
      case 0:
        return AnalyzePage(
          timelineModel: model,
          transactionId: transactionId,
        );
      case 1:
        return SamplePage(
          timelineModel: model,
          transactionId: transactionId,
        );
        break;
      case 2:
        return DiagnosePage(
          timelineModel: model,
          transactionId: transactionId,
        );
      case 3:
        return MedicineListPage(
          timelineModel: model,
          transactionId: transactionId,
        );
      default:
    }
  }
}
