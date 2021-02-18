import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:mobile_doctors_apps/model/request_doctor_model.dart';
import 'package:mobile_doctors_apps/repository/doctor_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();

  FirebaseUser _firebaseuser;
  DatabaseReference _doctorRequest;

  StreamSubscription<geolocator.Position> homeTabPageStreamSubscription;

  RequestDoctorModel _doctorModel;
  RequestDoctorModel get doctorModel => _doctorModel;

  bool connecting = false;
  bool active = false;
  bool finding = false;

  isConnecting(bool connecting) {
    this.connecting = connecting;
    notifyListeners();
  }

  isActive(bool active) {
    this.active = active;
    notifyListeners();
  }

  isFinding(bool finding) {
    this.finding = finding;
    notifyListeners();
  }

  HomePageViewModel() {
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
    print(userId);

    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");
    // print("oke" + FirebaseDatabase.instance.databaseURL);

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
      Map doctorLocation = {
        "latitude": position.latitude.toString(),
        "longtitude": position.longitude.toString(),
      };
      _doctorRequest.child(userId).update({
        "pickup": doctorLocation,
      });
    });
  }

  Future<void> cancelRequest() async {
    _firebaseuser = await FirebaseAuth.instance.currentUser();
    String userId = _firebaseuser.uid;
    homeTabPageStreamSubscription.pause();
    Geofire.removeLocation(userId);
    await _doctorRequest.child(userId).remove();
  }

  Future<bool> loadPatient() async {
    await Future.delayed(Duration(seconds: 5));

    return true;
  }
}
