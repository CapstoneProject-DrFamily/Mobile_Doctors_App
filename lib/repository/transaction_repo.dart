import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/feedback/feedback_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/examination_history_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/patient_transaction_model.dart';
import 'package:mobile_doctors_apps/model/profile/profile_model.dart';
import 'package:mobile_doctors_apps/model/service/service_model.dart';
import 'package:mobile_doctors_apps/model/symptom/symptom_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';
import 'package:mobile_doctors_apps/model/transaction_booking_model.dart';
import 'package:mobile_doctors_apps/model/transaction_history_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/home_page_view_model.dart';

abstract class ITransactionRepo {
  Future<TransactionBasicModel> getTransactionDetail(
      String transactionId, double currentLongitude, double currentLatitude);

  Future<bool> updateTransaction(Transaction transaction);
  Future<bool> deleteTransaction(String transactionId);

  Future<List<dynamic>> getTransactionHistory(String transactionId);
  Future<List<TransactionHistoryModel>> getListTransactionHistory(
      String doctorId, int status);
  Future<TransactionBasicModel> getTransactionDetailMap(String transactionId);
  Future<List<TransactionBookingModel>> getListTransactionBookingInDay(
      int doctorId);
  Future<List<dynamic>> getTransactionPatientDetail(String transactionId);
  Future<List<String>> getListPatientTransactionId(int patientId);
  Future<String> addBookingTransaction(String transactionJson);
  Future<List<String>> addListTransaction(String transactionJson);
  Future<List<TransactionHistoryModel>> getListPatientRecord(
      int patientId, int status);
}

class TransactionRepo extends ITransactionRepo {
  @override
  Future<TransactionBasicModel> getTransactionDetail(String transactionId,
      double currentLongitude, double currentLatitude) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in get transaction" + transactionId.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Transactions/$transactionId");
    var response = await http.get(uri, headers: header);

    TransactionBasicModel transactionBasic;

    if (response.statusCode == 200) {
      String transactionID = "";
      String symptomName = "";

      String patientName = "";
      String patientImage = "";
      String patientNote = "";

      String latitude = "";
      String longitude = "";
      String placeName = "";

      String serviceName = "";

      int doctorId = 0;
      int patientId = 0;
      int accountId = 0;
      String location = "";

      double servicePrice = 0;

      double distanceKM = 0;

      Map<String, dynamic> transactionSimpleInfo = jsonDecode(response.body);
      // List<SymptomTempModel> listSymptom =
      //     (transactionSimpleInfo['symptomDetails'] as List)
      //         .map((data) => SymptomTempModel.fromJson(data))
      //         .toList();
      String locationTemp = transactionSimpleInfo['location'];

      longitude = locationTemp.split(',')[1].split(':')[1].split(';')[0];

      latitude = locationTemp.split(',')[0].split(':')[1];

      print('longitude: $longitude, latitude $latitude');

      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDccJwe-72W30lGDAhHM98DHjqESsfInUg';

      http.Response responseMap = await http.get(url);
      if (responseMap.statusCode == 200) {
        String jSonData = responseMap.body;
        var decodeData = jsonDecode(jSonData);
        placeName = decodeData["results"][0]["formatted_address"];
      } else {}

      double distance = Geolocator.distanceBetween(currentLatitude,
          currentLongitude, double.parse(latitude), double.parse(longitude));

      distanceKM = double.parse((distance / 1000).toStringAsFixed(1));

      // if (listSymptom != null) {
      //   for (int i = 0; i < listSymptom.length; i++) {
      //     if (i == listSymptom.length - 1) {
      //       symptomName = symptomName + listSymptom[i].symptomName.toString();
      //     } else {
      //       symptomName =
      //           symptomName + listSymptom[i].symptomName.toString() + ", ";
      //     }
      //   }
      // } else {
      //   symptomName = null;
      // }

      patientName =
          transactionSimpleInfo["patient"]["patientNavigation"]["fullName"];
      patientImage =
          transactionSimpleInfo["patient"]["patientNavigation"]["image"];
      transactionID = transactionSimpleInfo["transactionId"];
      patientNote = transactionSimpleInfo["note"];
      doctorId = transactionSimpleInfo["doctorId"];
      patientId = transactionSimpleInfo["patientId"];
      location = locationTemp;
      serviceName = transactionSimpleInfo['service']['serviceName'];
      servicePrice = transactionSimpleInfo['service']['servicePrice'];
      accountId =
          transactionSimpleInfo['patient']['patientNavigation']['accountId'];

      print('$serviceName - $symptomName');
      int endTime = DateTime.now().millisecondsSinceEpoch +
          1000 * HomePageViewModel.timeOut;

      transactionBasic = TransactionBasicModel(
        transactionId: transactionId,
        distance: distanceKM,
        endTime: endTime,
        locationName: placeName,
        patientName: patientName,
        symptomName: symptomName,
        latitude: double.parse(latitude),
        longitude: double.parse(longitude),
        patientImage: patientImage,
        // patientSymptom: listSymptom,
        patientNote: patientNote,
        doctorId: doctorId,
        location: location,
        patientId: patientId,
        serviceName: serviceName,
        servicePrice: servicePrice,
      );
      transactionBasic.accountId = accountId;

      return transactionBasic;
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateTransaction(Transaction transaction) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.TRANSACTION_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.put(urlAPI,
        headers: header, body: jsonEncode(transaction.toJson()));

    print('statusTransaction ${response.statusCode}');

    if (response.statusCode == 200) {
      isSuccess = true;
    }

    return isSuccess;
  }

  @override
  Future<List<dynamic>> getTransactionHistory(String transactionId) async {
    List<dynamic> list = [];
    Transaction transaction = null;
    String urlAPI = APIHelper.TRANSACTION_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI + "/$transactionId", headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      transaction = Transaction.fromJson(data);

      ProfileModel profileUser =
          ProfileModel.fromJson(data['patient']['patientNavigation']);

      ServiceModel service = ServiceModel.fromJson(data['service']);

      List<SymptomModel> listSymptom = [];

      // int sizeSym = data['symptomDetails'].length;
      // for (int i = 0; i < sizeSym; i++) {
      //   SymptomModel symp =
      //       SymptomModel.fromJson(data['symptomDetails'][i]['symptom']);

      //   listSymptom.add(symp);
      // }

      // FEEDBACK
      FeedbackModel feedback;
      urlAPI = APIHelper.FEEDBACK_API;
      response = await http.get(urlAPI + "/$transactionId", headers: header);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        feedback = FeedbackModel.fromJson(data);
      }

      list.add(transaction);
      list.add(profileUser);
      list.add(service);
      list.add(listSymptom);
      list.add(feedback);
    }

    return list;
  }

  Future<List<TransactionHistoryModel>> getListTransactionHistory(
      String doctorId, int status) async {
    String urlAPI = APIHelper.TRANSACTION_DOCTOR_API +
        doctorId +
        "?status=" +
        status.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    List<TransactionHistoryModel> listTransactionHistoryModel;

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      listTransactionHistoryModel = (json.decode(response.body) as List)
          .map((data) => TransactionHistoryModel.fromJson(data))
          .toList();
      if (listTransactionHistoryModel.isEmpty)
        return null;
      else
        return listTransactionHistoryModel;
    } else
      return null;
  }

  @override
  Future<TransactionBasicModel> getTransactionDetailMap(
      String transactionId) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in get transaction" + transactionId.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Transactions/$transactionId");
    var response = await http.get(uri, headers: header);

    TransactionBasicModel transactionBasic;

    print("transaction ${response.statusCode}");

    if (response.statusCode == 200) {
      String transactionID = "";
      String symptomName = "";

      String patientName = "";
      String patientImage = "";
      String patientNote = "";

      String latitude = "";
      String longitude = "";
      String placeName = "";

      String serviceName = "";

      int doctorId = 0;
      int patientId = 0;
      int accountId = 0;
      int examId = 0;
      String location = "";

      double servicePrice = 0;

      String estimateTime = "";

      Map<String, dynamic> transactionSimpleInfo = jsonDecode(response.body);
      // List<SymptomTempModel> listSymptom =
      //     (transactionSimpleInfo['symptomDetails'] as List)
      //         .map((data) => SymptomTempModel.fromJson(data))
      //         .toList();
      String locationTemp = transactionSimpleInfo['location'];

      longitude = locationTemp.split(',')[1].split(':')[1].split(';')[0];

      latitude = locationTemp.split(',')[0].split(':')[1];

      placeName = locationTemp.split(";")[1].split(":")[1];

      // if (listSymptom != null) {
      //   for (int i = 0; i < listSymptom.length; i++) {
      //     if (i == listSymptom.length) {
      //       symptomName = symptomName + listSymptom[i].symptomName.toString();
      //     } else {
      //       symptomName =
      //           symptomName + listSymptom[i].symptomName.toString() + ", ";
      //     }
      //   }
      // } else {
      //   symptomName = null;
      // }

      patientName =
          transactionSimpleInfo["patient"]["patientNavigation"]["fullName"];
      patientImage =
          transactionSimpleInfo["patient"]["patientNavigation"]["image"];
      transactionID = transactionSimpleInfo["transactionId"];
      patientNote = transactionSimpleInfo["note"];
      doctorId = transactionSimpleInfo["doctorId"];
      patientId = transactionSimpleInfo["patientId"];
      location = locationTemp;
      serviceName = transactionSimpleInfo['service']['serviceName'];
      servicePrice = transactionSimpleInfo['service']['servicePrice'];
      estimateTime = transactionSimpleInfo['estimatedTime'];
      accountId =
          transactionSimpleInfo['patient']['patientNavigation']['accountId'];

      print('$serviceName - $symptomName');

      transactionBasic = TransactionBasicModel(
        transactionId: transactionId,
        locationName: placeName,
        patientName: patientName,
        symptomName: symptomName,
        latitude: double.parse(latitude),
        longitude: double.parse(longitude),
        patientImage: patientImage,
        // patientSymptom: listSymptom,
        patientNote: patientNote,
        doctorId: doctorId,
        location: location,
        patientId: patientId,
        serviceName: serviceName,
        servicePrice: servicePrice,
      );
      transactionBasic.estimateTime = estimateTime;
      transactionBasic.accountId = accountId;

      return transactionBasic;
    } else {
      return null;
    }
  }

  @override
  Future<List<TransactionBookingModel>> getListTransactionBookingInDay(
      int doctorId) async {
    String urlAPI = APIHelper.TRANSACTION_DOCTOR_API + '$doctorId?status=0';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<TransactionBookingModel> _listTransactionBooking = [];

    if (response.statusCode == 200) {
      _listTransactionBooking = (json.decode(response.body) as List)
          .map((data) => TransactionBookingModel.fromJson(data))
          .toList();
      print('booking List ${_listTransactionBooking.length}');
      if (_listTransactionBooking.isEmpty) return null;

      return _listTransactionBooking;
    } else
      return null;
  }

  @override
  Future<List> getTransactionPatientDetail(String transactionId) async {
    List<dynamic> list = [];
    String urlAPI = APIHelper.TRANSACTION_API + "/" + transactionId.trim();
    print('transactionID $transactionId');

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      PatientTransactionModel transaction =
          PatientTransactionModel.fromJson(data);

      ProfileModel profilePatient =
          ProfileModel.fromJson(data['patient']['patientNavigation']);
      String doctorSpeciality = data['doctor']['specialty']['name'];

      ProfileModel profileDoctor =
          ProfileModel.fromJson(data['doctor']['doctorNavigation']);

      ServiceModel service = ServiceModel.fromJson(data['service']);
      ExaminationHistoryModel examination =
          ExaminationHistoryModel.fromJson(data['examinationHistory']);

      // FEEDBACK
      FeedbackModel feedback;
      urlAPI = APIHelper.FEEDBACK_API;
      response = await http.get(urlAPI + "/$transactionId", headers: header);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        feedback = FeedbackModel.fromJson(data);
      }

      list.add(transaction);
      list.add(profilePatient);
      list.add(doctorSpeciality);
      list.add(service);
      list.add(examination);
      list.add(feedback);
      list.add(profileDoctor);
    }

    return list;
  }

  @override
  Future<List<String>> getListPatientTransactionId(int patientId) async {
    String urlAPI =
        APIHelper.TRANSACTION_PATIENT_API + patientId.toString() + "?status=3";
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    List<String> listTransactionId = [];

    var response = await http.get(urlAPI, headers: header);
    print('respose status ${response.statusCode}');
    if (response.statusCode == 200) {
      var listTransactionJson = (json.decode(response.body) as List).toList();

      for (int i = 0; i < listTransactionJson.length; i++) {
        var transactionId = listTransactionJson[i]['transactionId'];
        print(transactionId);
        listTransactionId.add(transactionId);
        print(listTransactionId.length);
      }

      if (listTransactionId.isEmpty)
        return null;
      else
        return listTransactionId;
    } else
      return null;
  }

  @override
  Future<String> addBookingTransaction(String transactionJson) async {
    String transactionID;
    String urlAPI = APIHelper.TRANSACTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.post(urlAPI, headers: header, body: transactionJson);

    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      transactionID = decodeData["transactionId"];
      return transactionID;
    } else
      return null;
  }

  @override
  Future<bool> deleteTransaction(String transactionId) async {
    String urlAPI = APIHelper.TRANSACTION_API + '/$transactionId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.delete(urlAPI, headers: header);
    print("Status code: " + response.statusCode.toString());
    bool isDelete = true;

    if (response.statusCode == 204) {
      return isDelete;
    } else {
      isDelete = false;
      return isDelete;
    }
  }

  @override
  Future<List<String>> addListTransaction(String transactionJson) async {
    List<String> listTransactionID = [];
    String urlAPI = APIHelper.TRANSACTION_API + "/GeneratedSchedule";

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.post(urlAPI, headers: header, body: transactionJson);

    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 201) {
      String jSonData = response.body;
      var list = (json.decode(response.body) as List);
      if (list.isEmpty) {
        return null;
      } else {
        for (int i = 0; i < list.length; i++) {
          var transactionId = list[i]["transactionId"];
          listTransactionID.add(transactionId);
        }
        return listTransactionID;
      }
    } else
      return null;
  }

  @override
  Future<List<TransactionHistoryModel>> getListPatientRecord(
      int patientId, int status) async {
    String urlAPI = APIHelper.TRANSACTION_PATIENT_API +
        patientId.toString() +
        "?status=" +
        status.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    List<TransactionHistoryModel> listTransactionHistoryModel;

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      listTransactionHistoryModel = (json.decode(response.body) as List)
          .map((data) => TransactionHistoryModel.fromJson(data))
          .toList();
      if (listTransactionHistoryModel.isEmpty)
        return null;
      else
        return listTransactionHistoryModel;
    } else
      return null;
  }
}
