import 'dart:async';
import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_doctors_apps/global_variable.dart';
import 'package:mobile_doctors_apps/helper/helper_method.dart';
import 'package:mobile_doctors_apps/model/direction_detail.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';
import 'package:mobile_doctors_apps/repository/map_repo.dart';
import 'package:mobile_doctors_apps/repository/notify_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/repository/user_repo.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPageViewModel extends BaseModel {
  final IMapRepo _mapRepo = MapRepo();
  final INotifyRepo _notifyRepo = NotifyRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IUserRepo _userRepo = UserRepo();

  final double _initFabHeight = 260.0;
  double _fabHeight;
  double get fabHeight => _fabHeight;
  double _panelHeightClosed = 240.0;
  double get panelHeightClosed => _panelHeightClosed;

  double _bottomPadding = 0;
  double get bottomPadding => _bottomPadding;

  Position _currentPosition;
  Position get currentPosition => _currentPosition;

  Completer<GoogleMapController> _controllerGoogle = Completer();
  Completer<GoogleMapController> get controllerGoogle => _controllerGoogle;
  GoogleMapController _controller;
  GoogleMapController get controller => _controller;

  CameraPosition _initPosition = CameraPosition(
    target: LatLng(10.7915178, 106.7271422),
    zoom: 11.0,
  );
  CameraPosition get initPosition => _initPosition;

  TransactionBasicModel _basicTransaction;
  TransactionBasicModel get basicTransaction => _basicTransaction;

  List<SymptomTempModel> symptomsDisplay = [];
  List<String> titleSymptom = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Set<Marker> _markers = Set<Marker>();
  Set<Marker> get markers => _markers;

  Set<Circle> _circles = Set<Circle>();
  Set<Circle> get circles => _circles;

  Set<Polyline> _polylines = Set<Polyline>();
  Set<Polyline> get polylines => _polylines;

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  Position myPosition;

  String durationString = "";

  FirebaseUser _firebaseuser;

  DatabaseReference _doctorRequest;

  String userId;

  DirectionDetails _directionDetails;
  DirectionDetails get directionDetails => _directionDetails;

  int _phoneNum;

  DatabaseReference _transactionRequest;

  MapPageViewModel(
      TransactionBasicModel transaction, DirectionDetails directionDetails) {
    _isLoading = true;
    _transactionRequest =
        FirebaseDatabase.instance.reference().child("Transaction");
    this._basicTransaction = transaction;
    this._directionDetails = directionDetails;
    _fabHeight = _initFabHeight;
    durationString = _basicTransaction.estimateTime;
    notifyListeners();
    initMap();
  }

  void initMap() async {
    _phoneNum = await _userRepo.getPhoneUser(_basicTransaction.accountId);

    _firebaseuser = await FirebaseAuth.instance.currentUser();
    userId = _firebaseuser.uid;
    _doctorRequest =
        FirebaseDatabase.instance.reference().child("Doctor Request");
    if (_basicTransaction.patientSymptom.isEmpty) {
      symptomsDisplay = [];
    } else {
      bool first = true;
      SymptomTempModel symptom;
      String sympTitle;
      List<SymptomTempModel> symptomsList = _basicTransaction.patientSymptom;
      String symptomName;
      for (int i = 0; i < symptomsList.length; i++) {
        if (titleSymptom.contains(symptomsList[i].symptomtype)) {
          if (i == (symptomsList.length - 1)) {
            symptomName = symptomName + symptomsList[i].symptomName;
          } else {
            symptomName = symptomName + symptomsList[i].symptomName + ", ";
          }
          first = false;
        } else {
          if (first == true) {
            titleSymptom.add(symptomsList[i].symptomtype);
            sympTitle = symptomsList[i].symptomtype;
            symptomName = "";
            symptomName = symptomName + symptomsList[i].symptomName + ", ";
          } else {
            first = true;
            symptomName = symptomName.substring(0, symptomName.length - 2);
            symptom = SymptomTempModel(
                symptomtype: sympTitle, symptomName: symptomName);
            symptomsDisplay.add(symptom);
            titleSymptom.add(symptomsList[i].symptomtype);
            sympTitle = symptomsList[i].symptomtype;
            if (i == (symptomsList.length - 1)) {
              symptomName = "";
              symptomName = symptomName + symptomsList[i].symptomName;
            } else {
              symptomName = "";
              symptomName = symptomName + symptomsList[i].symptomName + ", ";
            }
          }
        }
      }
      symptom =
          SymptomTempModel(symptomtype: sympTitle, symptomName: symptomName);
      symptomsDisplay.add(symptom);
    }

    getTransactionUpdate();

    _isLoading = false;

    notifyListeners();
  }

  void getTransactionUpdate() {
    transactionMapStreamSubscription = _transactionRequest
        .child(_basicTransaction.transactionId)
        .onChildRemoved
        .listen(
      (event) {
        HelperMethod.disableLiveLocationUpdates();
        HelperMethod.disableTransactionMapUpdates();

        Fluttertoast.showToast(
          msg: "Patient have Cancel Booking",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        Get.offAll(LandingScreen());
      },
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controllerGoogle.complete(controller);
    _controller = controller;

    _bottomPadding = 200;
    // HelperMethod.enableLiveLocationUpdates();
    print("map created");
    notifyListeners();

    locatePosition();

    getlocationUpdate();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    print("Position: " +
        position.latitude.toString() +
        " " +
        position.longitude.toString());

    LatLng destinationLocation =
        LatLng(basicTransaction.latitude, basicTransaction.longitude);

    await getDirection(latLngPosition, destinationLocation);

    notifyListeners();
  }

  void getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this._currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 16);
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void slidePanel(double pos, BuildContext context) {
    _fabHeight =
        pos * (MediaQuery.of(context).size.height * .80 - _panelHeightClosed) +
            _initFabHeight;
    notifyListeners();
  }

  Future<void> getDirection(
      LatLng currentPosition, LatLng destinationLocation) async {
    print("direction");
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result =
        polylinePoints.decodePolyline(_directionDetails.encodePoints);

    polylineCoordinates.clear();
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    _polylines.clear();

    Polyline polyline = Polyline(
      polylineId: PolylineId('polyid'),
      color: Color.fromARGB(255, 95, 109, 237),
      points: polylineCoordinates,
      jointType: JointType.round,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    _polylines.add(polyline);

    //make polyline to fit into map

    LatLngBounds bounds;

    if (currentPosition.latitude > destinationLocation.latitude &&
        currentPosition.longitude > destinationLocation.longitude) {
      bounds = LatLngBounds(
          southwest: destinationLocation, northeast: currentPosition);
    } else if (currentPosition.longitude > destinationLocation.longitude) {
      bounds = LatLngBounds(
          southwest:
              LatLng(currentPosition.latitude, destinationLocation.longitude),
          northeast:
              LatLng(destinationLocation.latitude, currentPosition.longitude));
    } else if (currentPosition.latitude > destinationLocation.latitude) {
      bounds = LatLngBounds(
          southwest:
              LatLng(destinationLocation.latitude, currentPosition.longitude),
          northeast:
              LatLng(currentPosition.latitude, destinationLocation.longitude));
    } else {
      bounds = LatLngBounds(
          southwest: currentPosition, northeast: destinationLocation);
    }

    _controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

    Marker currentMarker = Marker(
      markerId: MarkerId('current'),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    Marker destinationMarker = Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    _markers.add(currentMarker);
    _markers.add(destinationMarker);

    Circle destinationCirle = Circle(
        circleId: CircleId('destination'),
        strokeColor: Colors.red,
        strokeWidth: 2,
        radius: 4,
        center: destinationLocation,
        fillColor: Colors.red[50]);

    _circles.add(destinationCirle);

    notifyListeners();
  }

  void getlocationUpdate() {
    liveLocationStreamSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .listen((Position position) {
      print('live location');
      myPosition = position;
      this._currentPosition = position;

      LatLng pos = LatLng(position.latitude, position.longitude);

      CameraPosition cp = new CameraPosition(target: pos, zoom: 17);
      _controller.animateCamera(CameraUpdate.newCameraPosition(cp));

      // updateTripDetails();

      Map doctorLocation = {
        "latitude": position.latitude.toString(),
        "longtitude": position.longitude.toString(),
      };
      _doctorRequest.child(userId).update({
        "pickup": doctorLocation,
      });

      notifyListeners();
    });
  }

  void updateTripDetails() async {
    if (myPosition == null) {
      return;
    }

    var positionLatLng = LatLng(myPosition.latitude, myPosition.longitude);

    LatLng destinationLocation =
        LatLng(basicTransaction.latitude, basicTransaction.longitude);

    var directionDetails =
        await _mapRepo.getDirectionDetails(positionLatLng, destinationLocation);

    if (directionDetails != null) {
      print("location: " +
          directionDetails.durationText +
          " - " +
          directionDetails.distanceText);
      durationString =
          directionDetails.durationText + " - " + directionDetails.distanceText;
      notifyListeners();
    }
  }

  void btnArrived(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String usToken = prefs.getString("userToken");
    HelperMethod.disableLiveLocationUpdates();
    HelperMethod.disableTransactionMapUpdates();

    await _doctorRequest.child(userId).remove();

    _doctorRequest = FirebaseDatabase.instance.reference().child("Transaction");
    Map transactionInfo = {
      "doctor_FBId": userId,
      "transaction_status": "Analysis Symptom",
      "doctor_id": _basicTransaction.doctorId,
      "patientId": _basicTransaction.patientId,
      "estimatedTime": _basicTransaction.estimateTime,
      "location": _basicTransaction.location,
      "note": _basicTransaction.patientNote,
    };

    await _doctorRequest
        .child(_basicTransaction.transactionId)
        .set(transactionInfo);

    Transaction updateTransactionModel = Transaction(
        doctorId: _basicTransaction.doctorId,
        estimatedTime: _basicTransaction.estimateTime,
        location: _basicTransaction.location,
        note: _basicTransaction.patientNote,
        patientId: _basicTransaction.patientId,
        status: 2,
        transactionId: _basicTransaction.transactionId);

    _transactionRepo.updateTransaction(updateTransactionModel);

    _notifyRepo.arrivedTransaction(usToken, _basicTransaction.transactionId);
    prefs.remove("userToken");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BaseTimeLine(transactionId: _basicTransaction.transactionId),
      ),
    );
  }

  void callPhone(BuildContext context) async {
    await launch('tel://$_phoneNum');
  }

  Future<void> cancelTransaction() async {
    HelperMethod.disableTransactionMapUpdates();
    HelperMethod.disableLiveLocationUpdates();

    Transaction updateTransactionModel = Transaction(
        doctorId: _basicTransaction.doctorId,
        estimatedTime: _basicTransaction.estimateTime,
        location: _basicTransaction.location,
        note: _basicTransaction.patientNote,
        patientId: _basicTransaction.patientId,
        status: 4,
        transactionId: _basicTransaction.transactionId);

    _transactionRepo.updateTransaction(updateTransactionModel);

    await _transactionRequest.child(_basicTransaction.transactionId).remove();

    Get.back();
  }
}
