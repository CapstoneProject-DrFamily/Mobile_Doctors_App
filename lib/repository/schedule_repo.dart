import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';

abstract class IScheduleRepo {
  Future<bool> createSchedule(String jsonSchedule);
  Future<List<ScheduleModel>> loadListSchedule(
      String dateStart, String dateEnd, int doctorId);
}

class ScheduleRepo extends IScheduleRepo {
  @override
  Future<bool> createSchedule(String jsonSchedule) async {
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.post(urlAPI, headers: header, body: jsonSchedule);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);

      print('jsonValueSchedule $decodeData');
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<List<ScheduleModel>> loadListSchedule(
      String dateStart, String dateEnd, int doctorId) async {
    String urlAPI = APIHelper.SCHEDULE_API +
        '?startDate=$dateStart&endDate=$dateEnd&doctorId=$doctorId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<ScheduleModel> _listSchedule = [];

    if (response.statusCode == 200) {
      
      _listSchedule = (json.decode(response.body) as List)
          .map((data) => ScheduleModel.fromJson(data))
          .toList();

      if (_listSchedule.isEmpty) return null;

      return _listSchedule;
    } else
      return null;
  }
}
