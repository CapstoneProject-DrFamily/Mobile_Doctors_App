import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/health_record_model.dart';

abstract class IHealthRecordRepo {
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID);
}

class HealthRecordRepo extends IHealthRecordRepo {
  @override
  Future<HealthRecordModel> getHealthRecordByID(int healthRecordID) async {
    String urlAPI =
        APIHelper.GET_HEALTHRECORD_BY_ID_API + "/" + healthRecordID.toString();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status Heal: " + response.statusCode.toString());
    print("Json Health: " + response.body);

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
