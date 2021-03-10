import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';

abstract class ITransactionRepo {
  Future<TransactionBasicModel> getTransactionDetail(
      String transactionId, double currentLongitude, double currentLatitude);

  Future<bool> updateTransaction(Transaction transaction);
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
      String location = "";

      double servicePrice = 0;

      double distanceKM = 0;

      Map<String, dynamic> transactionSimpleInfo = jsonDecode(response.body);
      List<SymptomTempModel> listSymptom =
          (transactionSimpleInfo['symptomDetails'] as List)
              .map((data) => SymptomTempModel.fromJson(data))
              .toList();
      String locationTemp = transactionSimpleInfo['location'];
      List<String> locationPositionTemp = locationTemp.split(",");

      for (var item in locationPositionTemp) {
        List<String> positionTemp = item.split(":");
        if (positionTemp[0].endsWith("latitude"))
          latitude = positionTemp[1].trim();
        else
          longitude = positionTemp[1].trim();
      }
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
}
