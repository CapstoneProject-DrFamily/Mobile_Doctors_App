import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class WaitingSampleViewModel extends BaseModel {
  final ITransactionRepo _transactionRepo = TransactionRepo();
  DatabaseReference _transactionRequest;

  Future<void> continueChecking(
      BuildContext context, String transactionId) async {
    bool isConfirm = await _confirmDialog(context);
    if (isConfirm) {
      waitDialog(context, message: "Processing...");

      bool isSuccess = await updateTransaction(transactionId);
      Navigator.of(context).pop();
      if (isSuccess) {
        await CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.success,
            text: "Action complete",
            backgroundColor: Colors.lightBlue[200],
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => BaseTimeLine(
                        transactionId: transactionId,
                      )));
            });
      } else {
        await CoolAlert.show(
            barrierDismissible: false,
            context: context,
            type: CoolAlertType.error,
            text: "Action failed",
            backgroundColor: Colors.lightBlue[200],
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
      }
    }
  }

  Future<bool> updateTransaction(String transactionId) async {
    bool isUpdated = false;
    notifyListeners();
    // get transaction
    String step;

    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");

    await _transactionRequest
        .child(transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Transaction transaction = Transaction(
          transactionId: transactionId,
          doctorId: dataSnapshot.value['doctor_id'],
          patientId: dataSnapshot.value['patientId'],
          estimatedTime: dataSnapshot.value['estimatedTime'],
          status: 2,
          location: dataSnapshot.value['location'],
          note: dataSnapshot.value['note'],
        );

        step = dataSnapshot.value['transaction_status'];

        isUpdated = await _transactionRepo.updateTransaction(transaction);

        notifyListeners();
        return isUpdated;
      }
    });

    if (step != null) {
      var temp = step.split(";")[1];

      await _transactionRequest.child(transactionId).update({
        "transaction_status": "$temp",
      });
    }

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
            width: MediaQuery.of(bookingContext).size.width * 0.8,
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
                    'Are you sure you want to continue?',
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
                      onTap: () {
                        Navigator.pop(bookingContext, true);
                        // Navigator.pop(context);
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
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
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
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
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
}
