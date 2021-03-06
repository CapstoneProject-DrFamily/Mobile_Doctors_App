import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class INotifyRepo {
  Future<void> cancelTransaction(String usToken, String transactionId);
  Future<void> acceptTransaction(String usToken);
  Future<void> arrivedTransaction(String usToken, String transactionId);
  Future<void> cancelSchedule(String usToken, String doctorname,
      String patientName, String appointmentTime);
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
  Future<void> acceptTransaction(String usToken) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'please go back screen to tracking doctor',
            'title': 'DOCTOR HAVE ACCEPT YOU'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'accept',
            'type': 'booking',
          },
          'to': usToken,
        },
      ),
    );
  }

  @override
  Future<void> arrivedTransaction(String usToken, String transactionId) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print(transactionId);

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Please go Check',
            'title': 'DOCTOR HAS ARRIVED'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'transactionId': transactionId,
            'status': 'arrived',
            'type': 'booking',
          },
          'to': usToken,
        },
      ),
    );
  }

  @override
  Future<void> cancelSchedule(String usToken, String doctorname,
      String patientName, String appointmentTime) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    String appointTime = DateFormat("dd-MM-yyyy - HH:mm")
        .format(DateTime.parse(appointmentTime))
        .toString();
    String body =
        "Doctor $doctorname has cancel appointment $patientName at $appointTime";

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '$body',
            'title': 'DOCTOR HAS CANCEL SCHEDULE'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'cancel',
            'type': 'schedule',
          },
          'to': usToken,
        },
      ),
    );
  }
}
