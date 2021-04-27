import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotifycationService {
  // static List<TransactionNoti> transaction = [];
  static bool isSchedule = false;
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize() async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("in mess");
        print(message);
        String typeNoti = message['data']['type'];
        print('typeNoti $typeNoti');
        if (typeNoti.endsWith("booking")) {
          String status = message['data']['status'];
          if (status.endsWith("waiting")) {
            // bookTransaction(message);
          } else if (status.endsWith("cancel")) {
            // var transactionId = message['data']['transactionId'];
            // transactionRemove = transactionId;
            // transaction.removeWhere(
            //     (element) => element.transactionID == transactionRemove);
          } else if (status.endsWith("end")) {
            // print("in cancel");
            // endTransaction();
          }
          print('booking');
        } else if (typeNoti.endsWith("schedule")) {
          isSchedule = true;
          String info = message['notification']['body'];
          String formatInfo = info.substring(0, info.length - 1);
          print("in schedule");
          Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Container(
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
                      "New Appointment!",
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
                    Text(
                      '$formatInfo!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'avenir',
                        color: Colors.black,
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
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Text(
                              "Oke",
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
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("in lauch");
        String typeNoti = message['data']['type'];
        print('typeNoti $typeNoti');
        if (typeNoti.endsWith('booking')) {
          print('booking');
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("in resum");

        String typeNoti = message['data']['type'];
        print('typeNoti $typeNoti');
        if (typeNoti.endsWith('booking')) {
          print('booking');
        }
      },
    );
  }

  Future<String> getToken() async {
    String token = await fcm.getToken();
    print('Token: $token');

    fcm.subscribeToTopic('allDoctors');
    fcm.subscribeToTopic('allUsers');

    return token;
  }

  // void bookTransaction(Map<String, dynamic> message) {
  //   var transactionId = message['data']['transactionId'];
  //   var notifyToken = message['data']['notiToken'];

  //   TransactionNoti transactionNoti =
  //       TransactionNoti(transactionID: transactionId, notifyToken: notifyToken);
  //   transaction.add(transactionNoti);
  //   print("notiTransLengh: ${transaction.length}");
  // }

  // void endTransaction() {
  //   Get.back();
  //   Fluttertoast.showToast(
  //     msg: "Patient Have Cancel.",
  //     textColor: Colors.red,
  //     toastLength: Toast.LENGTH_SHORT,
  //     backgroundColor: Colors.white,
  //     gravity: ToastGravity.CENTER,
  //   );
  // }
}

class TransactionNoti {
  final String transactionID, notifyToken;

  TransactionNoti({this.notifyToken, this.transactionID});
}
