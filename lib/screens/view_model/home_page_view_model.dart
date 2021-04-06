import 'dart:async';

import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_doctors_apps/global_variable.dart';
import 'package:mobile_doctors_apps/helper/helper_method.dart';
import 'package:mobile_doctors_apps/helper/pushnotifycation_service.dart';
import 'package:mobile_doctors_apps/model/request_doctor_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';
import 'package:mobile_doctors_apps/repository/appconfig_repo.dart';
import 'package:mobile_doctors_apps/repository/doctor_repo.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/repository/map_repo.dart';
import 'package:mobile_doctors_apps/repository/notify_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/home/map_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/map_page_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  final IMapRepo _mapRepo = MapRepo();
  final IAppConfigRepo _appConfigRepo = AppConfigRepo();
  static int timeOut = 0;

  FirebaseUser _firebaseuser;
  DatabaseReference _doctorRequest;

  String _userFBID;

  RequestDoctorModel _doctorModel;
  RequestDoctorModel get doctorModel => _doctorModel;

  static bool checkStatus = false;

  bool connecting = false;
  bool active = false;
  bool finding = false;

  int sltransaction = 1;

  geolocator.Position _currentPosition;

  List<TransactionBasicModel> _listTransaction = [];
  List<TransactionBasicModel> get listTransaction => _listTransaction;

  isConnecting(bool connecting) {
    this.connecting = connecting;
    notifyListeners();
  }

  isActive(bool active) {
    this.active = active;
    checkStatus = active;
    notifyListeners();
  }

  isFinding(bool finding) {
    this.finding = finding;
    notifyListeners();
  }

  HomePageViewModel() {
    print('listtran ${_listTransaction.length}');

    init();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("usPhone");
    int profileID = prefs.get("usProfileID");
    int userID = prefs.get("usAccountID");

    var timeOutVar = await _appConfigRepo.appConfigTimeOut();
    timeOut = timeOutVar;
    print("timeOut $timeOut");

    _doctorModel = await _doctorRepo.getSimpleInfo(profileID);
    prefs.setString("usImage", _doctorModel.doctorImage);
    prefs.setString("usName", _doctorModel.doctorName);
    prefs.setInt("doctorId", _doctorModel.doctorId);
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      // Use location.
    }

    _firebaseuser = await FirebaseAuth.instance.currentUser();
    _userFBID = _firebaseuser.uid;

    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    _doctorRequest.child(_userFBID).once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        String status = dataSnapshot.value['doctor_status'];
        if (status != null && status == "waiting") {
          this.active = true;
          checkStatus = true;
          this.finding = true;
          getLocationLiveUpdates();
        }
      }
    });

    notifyListeners();

    print("Phone: " +
        phone +
        " ProfileID: " +
        profileID.toString() +
        " AccountID: " +
        userID.toString());

    print("Doctor: " + _doctorModel.doctorId.toString());
  }

  Future<bool> activeDoc() async {
    print('Firebase ID $_userFBID');
    PushNotifycationService pushNotifycationService = PushNotifycationService();

    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    geolocator.Position position;
    try {
      position = await geolocator.Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
    } catch (e) {
      print("error");
    }

    var status = await Permission.location.status;

    if (status.isUndetermined) {
      this.active = false;
      this.finding = false;
      this.connecting = false;
      notifyListeners();
      return false;
    }

    _currentPosition = position;

    await pushNotifycationService.initialize();

    String tokenNoti = await pushNotifycationService.getToken();

    Map doctorLocation = {
      "latitude": position.latitude.toString(),
      "longtitude": position.longitude.toString(),
    };

    Map doctorRequestInfo = {
      "pickup": doctorLocation,
      "created_at": DateTime.now().toString(),
      "doctor_id": _doctorModel.doctorId.toString(),
      "doctor_name": _doctorModel.doctorName,
      "doctor_image": _doctorModel.doctorImage,
      "doctor_specialty": _doctorModel.doctorSpecialty,
      "doctor_service_id": _doctorModel.doctorServiceId,
      "doctor_raiting_point": _doctorModel.doctorRatingPoint,
      "doctor_feedback_count": _doctorModel.doctorFeedBackCount,
      "doctor_booked_count": _doctorModel.doctorbooked,
      "doctor_status": "waiting",
      "token": tokenNoti,
    };

    _doctorRequest.child(_userFBID).set(doctorRequestInfo);

    getTransactionBookingListen();
    cancelTransactionListen();

    return true;
  }

  Future<void> getLocationLiveUpdates() async {
    homeTabPageStreamSubscription = geolocator.Geolocator.getPositionStream(
            desiredAccuracy: geolocator.LocationAccuracy.bestForNavigation)
        .listen((geolocator.Position position) {
      print("home location");
      _currentPosition = position;

      Map doctorLocation = {
        "latitude": position.latitude.toString(),
        "longtitude": position.longitude.toString(),
      };
      _doctorRequest.child(_userFBID).update({
        "pickup": doctorLocation,
      });
    });
  }

  Future<void> offlineDoctor() async {
    if (_listTransaction.isNotEmpty) {
      for (var item in _listTransaction) {
        await _doctorRequest
            .child(_userFBID)
            .child("transaction")
            .child(item.transactionId)
            .update(
          {
            "status": "offline",
          },
        );
      }
      _listTransaction = [];
      notifyListeners();
    }

    await transactionBookingStreamSubscription?.cancel();
    await transactionCancelStreamSubscription?.cancel();
    await homeTabPageStreamSubscription?.cancel();
    await _doctorRequest.child(_userFBID).remove();
  }

  void getTransactionBookingListen() {
    transactionBookingStreamSubscription = _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .onChildAdded
        .listen(
      (event) async {
        print(
            'Get TransactionID: ${event.snapshot.key} TransactionValue: ${event.snapshot.value}');

        await addTransaction(event.snapshot.key, _currentPosition.longitude,
            _currentPosition.latitude);
      },
    );
  }

  void cancelTransactionListen() {
    transactionCancelStreamSubscription = _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .onChildRemoved
        .listen(
      (event) async {
        print(
            'TransactionID: ${event.snapshot.key} TransactionValue: ${event.snapshot.value}');
        patientCancelTransaction(event.snapshot.key);
      },
    );
  }

  Future<void> addTransaction(
      String transactionID, double longitude, double latitude) async {
    TransactionBasicModel transactionBasic = await _transactionRepo
        .getTransactionDetail(transactionID, longitude, latitude);
    _listTransaction.add(transactionBasic);
    notifyListeners();
  }

  void patientCancelTransaction(String transactionID) {
    _listTransaction
        .removeWhere((element) => element.transactionId == transactionID);
    notifyListeners();
  }

  Future<void> cancelTransaction(
      String transactionID, BuildContext context) async {
    waitDialog(context, message: "Canceling request please wait...");
    await _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .child(transactionID)
        .update(
      {
        "status": "notbook",
      },
    );
    print("transactionId $transactionID");
    await _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .child(transactionID)
        .remove();

    _listTransaction
        .removeWhere((element) => element.transactionId == transactionID);
    Navigator.pop(context);
    notifyListeners();
  }

  Future<void> acceptTransaction(
      String transactionID, BuildContext context) async {
    waitDialog(
      context,
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int indexTransaction = _listTransaction
        .indexWhere((element) => element.transactionId == transactionID);
    var transaction = _listTransaction[indexTransaction];
    _listTransaction.removeAt(indexTransaction);

    LatLng destinationLocation =
        LatLng(transaction.latitude, transaction.longitude);
    LatLng positionLatLng =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);

    var directionDetails =
        await _mapRepo.getDirectionDetails(positionLatLng, destinationLocation);
    var firstEstimate =
        DateTime.now().add(Duration(seconds: directionDetails.durationValue));
    var secondEstimate = firstEstimate.add(Duration(minutes: 15));

    String estimatedTime = firstEstimate.hour.toString() +
        ":" +
        firstEstimate.minute.toString() +
        " - " +
        secondEstimate.hour.toString() +
        ":" +
        secondEstimate.minute.toString();

    String creator = prefs.getString("usName");

    String idExamination = await _examinationRepo.createNewExamination(
        transaction.transactionId, creator);

    Transaction transactionTemp = new Transaction(
        doctorId: transaction.doctorId,
        location: transaction.location,
        note: transaction.patientNote,
        patientId: transaction.patientId,
        status: 1,
        transactionId: transaction.transactionId,
        estimatedTime: estimatedTime);
    await _transactionRepo.updateTransaction(transactionTemp);

    print('examId: $idExamination');

    // // await offlineDoctor();
    HelperMethod.disableBookTransactionUpdates();
    HelperMethod.disableCancelTransactionUpdates();
    HelperMethod.disableHomeTabLocationUpdates();

    _doctorRequest.child(_userFBID).update({
      "doctor_status": "busy",
    });

    transaction.estimateTime = estimatedTime;
    for (var item in _listTransaction) {
      await _doctorRequest
          .child(_userFBID)
          .child("transaction")
          .child(item.transactionId)
          .update(
        {
          "status": "cancel",
        },
      );
    }

    print("done list Cancel");

    var patientNotiToken;

    await _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .child(transaction.transactionId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      prefs.setString("userToken", dataSnapshot.value['usNotiToken']);
      patientNotiToken = dataSnapshot.value['usNotiToken'];
    });

    await _doctorRequest
        .child(_userFBID)
        .child("transaction")
        .child(transaction.transactionId)
        .update(
      {
        "status": "accept",
      },
    );

    print("accept Transaction");
    isConnecting(false);
    isActive(false);
    isFinding(false);
    _listTransaction = [];

    _doctorRequest = FirebaseDatabase.instance.reference().child("Transaction");
    Map transactionInfo = {
      "doctor_FBId": _userFBID,
      "doctor_id": transaction.doctorId,
      "patientId": transaction.patientId,
      "estimatedTime": transaction.estimateTime,
      "location": transaction.location,
      "note": transaction.patientNote,
    };

    await _doctorRequest.child(transaction.transactionId).set(transactionInfo);

    notifyListeners();
    await _notifyRepo.acceptTransaction(patientNotiToken);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          model: MapPageViewModel(transaction, directionDetails),
        ),
      ),
    ).then(
      (value) {
        HelperMethod.disableLiveLocationUpdates();
        HelperMethod.disableBookTransactionUpdates();
        HelperMethod.disableCancelTransactionUpdates();
      },
    );
  }
}

class TransactionTemp {
  final String transactionID, patientNotiToken;
  TransactionTemp({this.patientNotiToken, this.transactionID});
}
