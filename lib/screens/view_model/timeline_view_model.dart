import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/enums/processState.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/record/diagnose_page.dart';
import 'package:mobile_doctors_apps/screens/record/sample_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class TimeLineViewModel extends BaseModel {
  int index = 0;
  int currentIndex = 0;
  bool init = true;

  DatabaseReference _transactionRequest;

  changeIndex(value) {
    this.currentIndex = value;
    notifyListeners();
  }

  Future<void> fetchData(transactionId) async {
    if (init) {
      print(transactionId);
      _transactionRequest =
          FirebaseDatabase.instance.reference().child("Transaction");
      await _transactionRequest
          .child(transactionId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot == null)
          return;
        else {
          String transaction_status = dataSnapshot.value["transaction_status"];
          switch (transaction_status) {
            case "Analysis Symptom":
              this.index = 0;
              this.currentIndex = 0;
              break;
            case "Take Sample":
              this.index = 1;
              this.currentIndex = 1;
              break;
            case "Diagnose":
              this.index = 2;
              this.currentIndex = 2;
              break;
            case "Prescription":
              this.index = 3;
              this.currentIndex = 3;
              break;
            default:
          }
        }
      });
      init = false;
    }
  }

  Future<void> skipTransaction(String transactionId) async {
    if (this.index == this.currentIndex) {
      _transactionRequest = FirebaseDatabase.instance
          .reference()
          .child("Transaction")
          .child(transactionId);

      await _transactionRequest.update({"transaction_status": "Diagnose"});
      this.index = ProcessState.DIAGNOSE;
    }
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
