import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PushNotifycationService {
  static List<TransactionNoti> transaction = [];
  static String transactionRemove;
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
            bookTransaction(message);
          } else if (status.endsWith("cancel")) {
            var transactionId = message['data']['transactionId'];
            transactionRemove = transactionId;
            transaction.removeWhere(
                (element) => element.transactionID == transactionRemove);
          } else if (status.endsWith("end")) {
            print("in cancel");
            endTransaction();
          }
          print('booking');
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

  void bookTransaction(Map<String, dynamic> message) {
    var transactionId = message['data']['transactionId'];
    var notifyToken = message['data']['notiToken'];

    TransactionNoti transactionNoti =
        TransactionNoti(transactionID: transactionId, notifyToken: notifyToken);
    transaction.add(transactionNoti);
    print("notiTransLengh: ${transaction.length}");
  }

  void endTransaction() {
    Get.back();
    Fluttertoast.showToast(
      msg: "Patient Have Cancel.",
      textColor: Colors.red,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }
}

class TransactionNoti {
  final String transactionID, notifyToken;

  TransactionNoti({this.notifyToken, this.transactionID});
}
