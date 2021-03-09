import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';

abstract class IPrescriptionRepo {
  Future<int> createPrescription(String prescriptionJson);
}

class PrescriptionRepo extends IPrescriptionRepo {
  @override
  Future<int> createPrescription(String prescriptionJson) async {
    String urlAPI = APIHelper.PRESCRIPTION_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: prescriptionJson);
    print(response.statusCode);
    if (response.statusCode == 201) {
      int prescriptionId;

      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      prescriptionId = decodeData["prescriptionId"];

      return prescriptionId;
    } else {
      return null;
    }
  }
}
