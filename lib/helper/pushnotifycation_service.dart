import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotifycationService {
  static List<TransactionNoti> transaction = [];
  final FirebaseMessaging fcm = FirebaseMessaging();

  Future initialize() async {
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("in mess");
        print(message);
        String typeNoti = message['data']['type'];
        print('typeNoti $typeNoti');
        print(typeNoti.endsWith("booking"));
        if (typeNoti.endsWith("booking")) {
          var transactionId = message['data']['transactionId'];
          var notifyToken = message['data']['notiToken'];
          print('noti $transactionId $notifyToken');
          TransactionNoti transactionNoti = TransactionNoti(
              transactionID: transactionId, notifyToken: notifyToken);
          transaction.add(transactionNoti);
          print("lenght: ${transaction.length}");
          print(Get.context);
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
}

class TransactionNoti {
  final String transactionID, notifyToken;

  TransactionNoti({this.notifyToken, this.transactionID});
}
