import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/profile/profile_model.dart';
import 'package:mobile_doctors_apps/model/service/service_model.dart';
import 'package:mobile_doctors_apps/model/symptom/symptom_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';
import 'package:mobile_doctors_apps/model/transaction_history_model.dart';

abstract class ITransactionRepo {
  Future<TransactionBasicModel> getTransactionDetail(
      String transactionId, double currentLongitude, double currentLatitude);

  Future<bool> updateTransaction(Transaction transaction);

  Future<List<dynamic>> getTransactionHistory(String transactionId);
  Future<List<TransactionHistoryModel>> getListTransactionHistory(
      String doctorId, int status);
  Future<TransactionBasicModel> getTransactionDetailMap(String transactionId);
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
      List<SymptomTempModel> listSymptom =
          (transactionSimpleInfo['symptomDetails'] as List)
              .map((data) => SymptomTempModel.fromJson(data))
              .toList();
      String locationTemp = transactionSimpleInfo['location'];

      longitude = locationTemp.split(',')[1].split(':')[1].split(';')[0];

      latitude = locationTemp.split(',')[0].split(':')[1];

      String url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDFd7ZNm2BL2JREvk32NZJ0wHzUn2fjw4A';

      http.Response responseMap = await http.get(url);
      if (responseMap.statusCode == 200) {
        String jSonData = responseMap.body;
        var decodeData = jsonDecode(jSonData);
        placeName = decodeData["results"][0]["formatted_address"];
      } else {}

      double distance = await Geolocator.distanceBetween(currentLatitude,
          currentLongitude, double.parse(latitude), double.parse(longitude));

      distanceKM = double.parse((distance / 1000).toStringAsFixed(1));

      if (listSymptom != null) {
        for (int i = 0; i < listSymptom.length; i++) {
          if (i == listSymptom.length) {
            symptomName = symptomName + listSymptom[i].symptomName.toString();
          } else {
            symptomName =
                symptomName + listSymptom[i].symptomName.toString() + ", ";
          }
        }
      } else {
        symptomName = null;
      }

      patientName = transactionSimpleInfo["patient"]["profile"]["fullName"];
      patientImage = transactionSimpleInfo["patient"]["profile"]["image"];
      transactionID = transactionSimpleInfo["transactionId"];
      patientNote = transactionSimpleInfo["note"];
      doctorId = transactionSimpleInfo["doctorId"];
      patientId = transactionSimpleInfo["patientId"];
      location = locationTemp;
      serviceName = transactionSimpleInfo['service']['serviceName'];
      servicePrice = transactionSimpleInfo['service']['servicePrice'];
      accountId = transactionSimpleInfo['patient']['accountId'];

      print('$serviceName - $symptomName');
      int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

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
        patientSymptom: listSymptom,
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
          ProfileModel.fromJson(data['patient']['profile']);

      ServiceModel service = ServiceModel.fromJson(data['service']);

      List<SymptomModel> listSymptom = [];

      int sizeSym = data['symptomDetails'].length;
      for (int i = 0; i < sizeSym; i++) {
        SymptomModel symp = SymptomModel.fromJson(data['symptomDetails'][i]);
        listSymptom.add(symp);
      }

      list.add(transaction);
      list.add(profileUser);
      list.add(service);
      list.add(listSymptom);
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
      List<SymptomTempModel> listSymptom =
          (transactionSimpleInfo['symptomDetails'] as List)
              .map((data) => SymptomTempModel.fromJson(data))
              .toList();
      String locationTemp = transactionSimpleInfo['location'];

      longitude = locationTemp.split(',')[1].split(':')[1].split(';')[0];

      latitude = locationTemp.split(',')[0].split(':')[1];

      placeName = locationTemp.split(";")[1].split(":")[1];

      if (listSymptom != null) {
        for (int i = 0; i < listSymptom.length; i++) {
          if (i == listSymptom.length) {
            symptomName = symptomName + listSymptom[i].symptomName.toString();
          } else {
            symptomName =
                symptomName + listSymptom[i].symptomName.toString() + ", ";
          }
        }
      } else {
        symptomName = null;
      }

      patientName = transactionSimpleInfo["patient"]["profile"]["fullName"];
      patientImage = transactionSimpleInfo["patient"]["profile"]["image"];
      transactionID = transactionSimpleInfo["transactionId"];
      patientNote = transactionSimpleInfo["note"];
      doctorId = transactionSimpleInfo["doctorId"];
      patientId = transactionSimpleInfo["patientId"];
      location = locationTemp;
      serviceName = transactionSimpleInfo['service']['serviceName'];
      servicePrice = transactionSimpleInfo['service']['servicePrice'];
      estimateTime = transactionSimpleInfo['estimatedTime'];
      accountId = transactionSimpleInfo['patient']['accountId'];
      examId = transactionSimpleInfo['examId'];

      print('$serviceName - $symptomName');

      transactionBasic = TransactionBasicModel(
        transactionId: transactionId,
        locationName: placeName,
        patientName: patientName,
        symptomName: symptomName,
        latitude: double.parse(latitude),
        longitude: double.parse(longitude),
        patientImage: patientImage,
        patientSymptom: listSymptom,
        patientNote: patientNote,
        doctorId: doctorId,
        location: location,
        patientId: patientId,
        serviceName: serviceName,
        servicePrice: servicePrice,
      );
      transactionBasic.estimateTime = estimateTime;
      transactionBasic.accountId = accountId;
      transactionBasic.examId = examId;

      return transactionBasic;
    } else {
      return null;
    }
  }
}
