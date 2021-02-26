import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:mobile_doctors_apps/helper/pushnotifycation_service.dart';
import 'package:mobile_doctors_apps/model/request_doctor_model.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';
import 'package:mobile_doctors_apps/repository/doctor_repo.dart';
import 'package:mobile_doctors_apps/repository/notify_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();

  FirebaseUser _firebaseuser;
  DatabaseReference _doctorRequest;

  StreamSubscription<geolocator.Position> homeTabPageStreamSubscription;

  RequestDoctorModel _doctorModel;
  RequestDoctorModel get doctorModel => _doctorModel;

  static bool checkStatus = false;

  bool connecting = false;
  bool active = false;
  bool finding = false;

  int sltransaction = 1;

  List<TransactionBasicModel> _listTransaction = [];
  List<TransactionBasicModel> get listTransaction => _listTransaction;
  List<String> _listTempTransaction = [];

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
    print('list ${PushNotifycationService.transaction.length}');
    print('listtran ${_listTransaction.length}');

    init();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("usPhone");
    int profileID = prefs.get("usProfileID");
    int userID = prefs.get("usAccountID");

    _doctorModel = await _doctorRepo.getSimpleInfo(profileID);

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      // Use location.
    }

    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;

    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");

    _doctorRequest.child(userId).once().then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        String status = dataSnapshot.value['doctor_status'];
        if (status != null) {
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
    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;
    print('Firebase ID $userId');
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

    // if (await Permission.speech.isPermanentlyDenied) {}
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
      "doctor_status": "waiting",
      "token": tokenNoti,
    };

    _doctorRequest.child(userId).set(doctorRequestInfo);

    _doctorRequest.onValue.listen((event) {});
    return true;
  }

  Future<void> makeDoctorOnline() async {
    _firebaseuser = await FirebaseAuth.instance.currentUser();

    geolocator.Position position;
    try {
      position = await geolocator.Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
    } catch (e) {
      print("error");
    }

    _doctorRequest.onValue.listen((event) {});
  }

  Future<void> getLocationLiveUpdates() async {
    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;

    homeTabPageStreamSubscription = geolocator.Geolocator.getPositionStream()
        .listen((geolocator.Position position) async {
      geolocator.Position position =
          await geolocator.Geolocator.getCurrentPosition(
              desiredAccuracy: geolocator.LocationAccuracy.high);

      if (_listTempTransaction.length <
          PushNotifycationService.transaction.length) {
        //add transaction
        addTransaction(position.longitude, position.latitude);
      } else if (_listTempTransaction.length >
          PushNotifycationService.transaction.length) {
        String removeTransaction = PushNotifycationService.transactionRemove;
        patientCancelTransaction(removeTransaction);
      }

      Map doctorLocation = {
        "latitude": position.latitude.toString(),
        "longtitude": position.longitude.toString(),
      };
      _doctorRequest.child(userId).update({
        "pickup": doctorLocation,
      });
    });
  }

  Future<void> offlineDoctor() async {
    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;
    await homeTabPageStreamSubscription?.cancel();
    await _doctorRequest.child(userId).remove();
  }

  Future<void> addTransaction(double longitude, double latitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_listTempTransaction.length == 0) {
      _listTempTransaction
          .add(PushNotifycationService.transaction[0].transactionID);
      TransactionBasicModel transactionBasic =
          await _transactionRepo.getTransactionDetail(
              PushNotifycationService.transaction[0].transactionID,
              longitude,
              latitude);
      _listTransaction.add(transactionBasic);
      //add
    } else {
      for (var item in PushNotifycationService.transaction) {
        if (_listTempTransaction.contains(item.transactionID)) {
          // print("contain");
          // _listTempTransaction.add(item);
          // await _transactionRepo.getTransactionDetail(item);
        } else {
          print("don't contain");
          _listTempTransaction.add(item.transactionID);
          TransactionBasicModel transactionBasic = await _transactionRepo
              .getTransactionDetail(item.transactionID, longitude, latitude);
          _listTransaction.add(transactionBasic);
        }
      }
    }
    // prefs.setStringList("listTransaction", );

    print(
        'Listtrantemp: ${_listTempTransaction.length}, ListRealTrans: ${_listTransaction.length}');
    notifyListeners();
  }

  void patientCancelTransaction(String transactionID) {
    _listTempTransaction.removeWhere((element) => element == transactionID);
    _listTransaction
        .removeWhere((element) => element.transactionId == transactionID);
    notifyListeners();
  }

  Future<void> cancelTransaction(String transactionID) async {
    print("in cacel");
    int indexTransaction = PushNotifycationService.transaction
        .indexWhere((element) => element.transactionID == transactionID);
    String tokenPatient =
        PushNotifycationService.transaction[indexTransaction].notifyToken;
    await _notifyRepo.cancelTransaction(tokenPatient, transactionID);
    PushNotifycationService.transaction
        .removeWhere((element) => element.transactionID == transactionID);
    _listTempTransaction.removeWhere((element) => element == transactionID);
    _listTransaction
        .removeWhere((element) => element.transactionId == transactionID);

    print(
        'List ${PushNotifycationService.transaction.length}  ${_listTempTransaction.length}  ${_listTransaction.length}');
    notifyListeners();
  }

  Future<void> acceptTransaction(String transactionID) async {
    int indexTransaction = PushNotifycationService.transaction
        .indexWhere((element) => element.transactionID == transactionID);
    String tokenPatient =
        PushNotifycationService.transaction[indexTransaction].notifyToken;
    await _notifyRepo.acceptTransaction(tokenPatient, transactionID);
    print(transactionID);
    await offlineDoctor();
    isConnecting(false);
    isActive(false);
    isFinding(false);
    PushNotifycationService.transaction = [];
    _listTempTransaction = [];
    _listTransaction = [];
    notifyListeners();
  }
}
