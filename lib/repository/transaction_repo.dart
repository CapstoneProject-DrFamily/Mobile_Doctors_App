import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/transaction_basic_model.dart';

abstract class ITransactionRepo {
  Future<TransactionBasicModel> getTransactionDetail(
      String transactionId, double currentLongitude, double currentLatitude);
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

      String latitude = "";
      String longitude = "";
      String placeName = "";

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

      for (int i = 0; i < listSymptom.length; i++) {
        if (i == listSymptom.length) {
          symptomName = symptomName + listSymptom[i].symptomName.toString();
        } else {
          symptomName =
              symptomName + listSymptom[i].symptomName.toString() + ", ";
        }
      }
      patientName = transactionSimpleInfo["patient"]["profile"]["fullName"];
      transactionID = transactionSimpleInfo["transactionId"];
      int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

      transactionBasic = TransactionBasicModel(
          transactionId: transactionId,
          distance: distanceKM,
          endTime: endTime,
          locationName: placeName,
          patientName: patientName,
          symptomName: symptomName);

      return transactionBasic;
    } else {
      return null;
    }
  }
}
