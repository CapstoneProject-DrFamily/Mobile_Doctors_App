import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/medicine_model.dart';
import 'package:mobile_doctors_apps/model/patient_transacion/patient_prescription_model.dart';

abstract class IPrescriptionRepo {
  Future<String> createPrescription(String prescriptionJson);
  Future<List<dynamic>> getPrescriptionDetail(String prescriptionId);
}

class PrescriptionRepo extends IPrescriptionRepo {
  @override
  Future<String> createPrescription(String prescriptionJson) async {
    String urlAPI = APIHelper.PRESCRIPTION_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: prescriptionJson);
    print('prescription status: ${response.statusCode}');
    if (response.statusCode == 201) {
      String prescriptionId;

      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      prescriptionId = decodeData["prescriptionId"];

      return prescriptionId;
    } else {
      return null;
    }
  }

  @override
  Future<List<dynamic>> getPrescriptionDetail(String prescriptionId) async {
    List<dynamic> result = [];
    List<PatientPrescriptionModel> list = [];

    String urlAPI = APIHelper.PRESCRIPTION_API;

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI + "/$prescriptionId", headers: header);
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < data['prescriptionDetails'].length; i++) {
        PatientPrescriptionModel prescription =
            PatientPrescriptionModel.fromJson(data['prescriptionDetails'][i]);
        MedicineModel medicine =
            MedicineModel.fromJson(data['prescriptionDetails'][i]['medicine']);
        prescription.medicine = medicine;
        list.add(prescription);
      }
    }
    result.add(list);
    result.add(data['description']);

    return result;
  }
}
