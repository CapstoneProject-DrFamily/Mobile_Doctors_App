import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

abstract class INotifyRepo {
  Future<void> cancelTransaction(String usToken, String transactionId);
  Future<void> acceptTransaction(
      String usToken, String transactionId, String doctorFBId);
}

class NotifyRepo extends INotifyRepo {
  final String serverToken =
      'AAAAERBD7G8:APA91bExZZNT0340wBRqrEcuhJrLCNvl7P9HCNDOTWIkB9hCqiJVMBrNdU44RRsM9c1alGKxmr_9ZPkEqOo8UooN-MktViUJXZzbNKCdfzlFX0QZghx0kCQ_48zqZoGA0faVePes29Ti';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  Future<void> cancelTransaction(String usToken, String transactionID) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print(transactionID);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'choose another doctor please',
            'title': 'DOCTOR HAVE CANCEL'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionID,
            'status': 'cancel',
            'type': 'booking',
          },
          'to': usToken,
        },
      ),
    );
  }

  @override
  Future<void> acceptTransaction(
      String usToken, String transactionID, String doctorFBId) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print(transactionID);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'choose another doctor please',
            'title': 'DOCTOR HAVE CANCEL'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionID,
            'doctorFBId': doctorFBId,
            'status': 'accept',
            'type': 'booking',
          },
          'to': usToken,
        },
      ),
    );
  }
}
