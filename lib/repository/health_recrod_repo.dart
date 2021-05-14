import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/health_record_model.dart';

abstract class IHealthRecordRepo {
  Future<HealthRecordModel> getHealthRecordByID(int patientID);
}

class HealthRecordRepo extends IHealthRecordRepo {
  @override
  Future<HealthRecordModel> getHealthRecordByID(int patientID) async {
    String urlAPI = APIHelper.GET_HEALTHRECORD_BY_ID_API +
        '?patientId=$patientID&isOldRecord=false';
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
}
