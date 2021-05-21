import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/health_record_model.dart';

abstract class IHealthRecordRepo {
  Future<HealthRecordModel> getCurrentHealthRecordByID(
      int patientID, bool isOldRecord);
  Future<List<HealthRecordModel>> getListOldHealthRecord(
      int patientID, bool isOldRecord);
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID);
}

class HealthRecordRepo extends IHealthRecordRepo {
  @override
  Future<HealthRecordModel> getCurrentHealthRecordByID(
      int patientID, bool isOldRecord) async {
    String urlAPI = APIHelper.GET_HEALTHRECORD_BY_ID_API +
        '?patientId=$patientID&isOldRecord=$isOldRecord';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status Heal: " + response.statusCode.toString());
    print("Json Health: " + response.body);
    List<HealthRecordModel> listHealthRecord;

    HealthRecordModel healthRecordModel;
    if (response.statusCode == 200) {
      listHealthRecord = (json.decode(response.body) as List)
          .map((data) => HealthRecordModel.fromJson(data))
          .toList();
      healthRecordModel = listHealthRecord.first;
      return healthRecordModel;
    } else {
      return null;
    }
  }

  @override
  Future<List<HealthRecordModel>> getListOldHealthRecord(
      int patientID, bool isOldRecord) async {
    String urlAPI = APIHelper.GET_HEALTHRECORD_BY_ID_API +
        '?patientId=$patientID&isOldRecord=$isOldRecord';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.get(urlAPI, headers: header);
    print("Status listOldPHR: " + response.statusCode.toString());
    print("listOldPHR: " + response.body);

    List<HealthRecordModel> listOldHealthRecord;
    if (response.statusCode == 200) {
      listOldHealthRecord = (json.decode(response.body) as List)
          .map((data) => HealthRecordModel.fromJson(data))
          .toList();
      listOldHealthRecord
          .sort((a, b) => b.insDatetime.compareTo(a.insDatetime));
      return listOldHealthRecord;
    } else {
      return null;
    }
  }

  @override
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID) async {
    String urlAPI =
        APIHelper.GET_HEALTHRECORD_BY_ID_API + "/" + healthRecordID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status getHealthRecordByID: " + response.statusCode.toString());
    print("Body getHealthRecordByID: " + response.body);

    HealthRecordModel healthRecordModel;
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      healthRecordModel = HealthRecordModel.fromJson(map);
      return healthRecordModel;
    } else {
      return null;
    }
  }
}
