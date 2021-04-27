import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/patient_model.dart';

abstract class IPatientRepo {
  Future<PatientModel> getPatientInfo(int patientId);
  Future<String> getPatientPhone(int patientId);
  Future<String> getPatientNotitoken(int patientID);
}

class PatientRepo extends IPatientRepo {
  @override
  Future<PatientModel> getPatientInfo(int patientId) async {
    String urlAPI = APIHelper.PATIENT_API + '/$patientId';

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      PatientModel patientModel;
      Map<String, dynamic> userJson = jsonDecode(response.body);
      patientModel = PatientModel.fromJson(userJson);
      print('patient ${patientModel.patientBloodType}');
      return patientModel;
    } else {
      return null;
    }
  }

  @override
  Future<String> getPatientPhone(int patientId) async {
    String urlAPI = APIHelper.PATIENT_API + '/$patientId';

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> userJson = jsonDecode(response.body);
      var phone = userJson['patientNavigation']['account']['username'];

      return phone;
    } else {
      return null;
    }
  }

  @override
  Future<String> getPatientNotitoken(int patientID) async {
    String urlAPI = APIHelper.PATIENT_API + '/$patientID';

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> userJson = jsonDecode(response.body);
      var tokenNoti = userJson['patientNavigation']['account']['notiToken'];

      return tokenNoti;
    } else {
      return null;
    }
  }
}
