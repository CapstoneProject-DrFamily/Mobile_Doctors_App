import 'package:commons/commons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/enums/processState.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/record/diagnose_page.dart';
import 'package:mobile_doctors_apps/screens/record/sample_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/health_record_page.dart';
import 'package:mobile_doctors_apps/screens/share/popup_info_patient_page.dart';

class TimeLineViewModel extends BaseModel {
  int index = 0;
  int currentIndex = 0;
  bool init = true;
  BuildContext buildContext;
  String transactionId;
  ITransactionRepo _transactionRepo = TransactionRepo();
  bool cancelTransaction = false;

  int patientId;

  DatabaseReference _transactionRequest;

  changeIndex(value) {
    this.currentIndex = value;
    notifyListeners();
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'End Transaction':
        print('End Transaction');
        bool isConfirm = await _confirmDialog(this.buildContext);
        if (isConfirm) {
          waitDialog(this.buildContext, message: "Ending Record...");
          bool isCancel = await endTransaction();

          if (isCancel) {
            Navigator.pop(this.buildContext);

            Fluttertoast.showToast(
              msg: "End this transaction success",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              gravity: ToastGravity.CENTER,
            );
            Navigator.pop(this.buildContext);
          } else {
            Navigator.pop(this.buildContext);

            Fluttertoast.showToast(
              msg: "End this transaction failed",
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER,
            );
            Navigator.pop(this.buildContext);
          }
        }
        break;
      case 'Patient Profile':
        print('Patient Profile');
        PatientDialog().showCustomDialog(this.buildContext, patientId);
        break;
      case 'Patient Health Record':
        print('Patient Health Record');
        Navigator.push(
          this.buildContext,
          MaterialPageRoute(
            builder: (context) => HealthRecordScreen(
              patientId: patientId,
            ),
          ),
        );
        break;
    }
  }

  Future<bool> endTransaction() async {
    bool isUpdated = false;
    this.cancelTransaction = true;
    notifyListeners();
    // get transaction
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _transactionRequest
        .child(transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Transaction transaction = Transaction(
          transactionId: this.transactionId,
          doctorId: dataSnapshot.value['doctor_id'],
          patientId: dataSnapshot.value['patientId'],
          estimatedTime: dataSnapshot.value['estimatedTime'],
          status: 4,
          location: dataSnapshot.value['location'],
          note: dataSnapshot.value['note'],
        );
        isUpdated = await _transactionRepo.updateTransaction(transaction);
        this.cancelTransaction = false;
        notifyListeners();
        return isUpdated;
      }
    });

    this.cancelTransaction = false;
    notifyListeners();
    return isUpdated;
  }

  Future _confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.info,
                  color: Color(0xff4ee1c7),
                  size: 90,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Confirmation?",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                    color: Color(0xff0d47a1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Are you sure you want to end this transaction?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'avenir',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.pop(bookingContext);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getIcon(String value) {
    switch (value) {
      case 'End Transaction':
        return Icon(Icons.cancel);
        break;
      case 'Patient Profile':
        return Icon(EvaIcons.person);
        break;
      case 'Patient Health Record':
        return Icon(EvaIcons.activity);
        break;
      case 'Waiting Examination':
        return Icon(Icons.analytics_outlined);
        break;
      default:
    }
  }

  Future<void> fetchData(String transactionId, BuildContext context) async {
    if (init) {
      this.transactionId = transactionId;
      this.buildContext = context;
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
          patientId = dataSnapshot.value["patientId"];
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
