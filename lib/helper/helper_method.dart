import 'package:mobile_doctors_apps/global_variable.dart';

class HelperMethod {
  static void disableHomeTabLocationUpdates() {
    homeTabPageStreamSubscription.pause();
  }

  static void enableHomeTabLocationUpdates() {
    homeTabPageStreamSubscription.resume();
  }

  static void disableLiveLocationUpdates() {
    liveLocationStreamSubscription.pause();
  }

  static void enableLiveLocationUpdates() {
    liveLocationStreamSubscription.resume();
  }

  static void disableBookTransactionUpdates() {
    transactionBookingStreamSubscription.pause();
  }

  static void enableBookTransactionUpdates() {
    transactionBookingStreamSubscription.resume();
  }

  static void disableCancelTransactionUpdates() {
    transactionCancelStreamSubscription.pause();
  }

  static void enableCancelTransactionUpdates() {
    transactionCancelStreamSubscription.resume();
  }
}
