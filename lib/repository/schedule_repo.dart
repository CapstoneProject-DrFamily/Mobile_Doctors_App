import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';
import 'package:mobile_doctors_apps/model/transaction_schedule_model.dart';

abstract class IScheduleRepo {
  Future<List<dynamic>> createSchedule(String jsonSchedule);
  Future<List<ScheduleModel>> loadListSchedule(
      String dateStart, String dateEnd, int doctorId);
  Future<bool> deleteScheduleNoTask(int scheduleId);
  Future<bool> updateSchedule(String scheduleUpdateJson);
  Future<List<bool>> checkIsActiveOk(int doctorId);
}

class ScheduleRepo extends IScheduleRepo {
  @override
  Future<List<dynamic>> createSchedule(String jsonSchedule) async {
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.post(urlAPI, headers: header, body: jsonSchedule);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;
    List<dynamic> listReturn = [];
    if (response.statusCode == 201) {
      String jsonData = response.body;
      print("jsonDataScheduleAdd $jsonData");
      List<ScheduleModel> listSchedule = (json.decode(response.body) as List)
          .map((data) => ScheduleModel.fromJson(data))
          .toList();

      listReturn.add(isCreated);
      listReturn.add(listSchedule);

      print('jsonValueSchedule ${listSchedule.length}');
      return listReturn;
    } else {
      isCreated = false;
      listReturn.add(isCreated);
      return listReturn;
    }
  }

  @override
  Future<List<ScheduleModel>> loadListSchedule(
      String dateStart, String dateEnd, int doctorId) async {
    String urlAPI = APIHelper.SCHEDULE_API +
        '?startDate=$dateStart&endDate=$dateEnd&doctorId=$doctorId';
    print("URL $urlAPI");
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<ScheduleModel> _listSchedule = [];
    print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      print("list schedule $jsonData");
      for (int i = 0; i < jsonData.length; i++) {
        print("json ${jsonData[i]['treatments']}");
        if (jsonData[i]['treatments'].isEmpty) {
          print("empty");
          ScheduleModel model = ScheduleModel(
            appointmentTime: jsonData[i]['appointmentTime'],
            scheduleId: jsonData[i]['id'],
            scheduleStatus: jsonData[i]['status'],
            updBy: jsonData[i]['updBy'],
            updDatetime: jsonData[i]['updDatetime'],
            transactionScheduleModel: null,
          );
          _listSchedule.add(model);
        } else {
          print("not empty");

          TransactionScheduleModel transactionScheduleModel =
              TransactionScheduleModel.fromJson(jsonData[i]['treatments'][0]);
          ScheduleModel model = ScheduleModel(
            appointmentTime: jsonData[i]['appointmentTime'],
            scheduleId: jsonData[i]['id'],
            scheduleStatus: jsonData[i]['status'],
            updBy: jsonData[i]['updBy'],
            updDatetime: jsonData[i]['updDatetime'],
            transactionScheduleModel: transactionScheduleModel,
          );
          _listSchedule.add(model);
        }
      }
      if (_listSchedule.isEmpty) return null;
      return _listSchedule;
    } else
      return null;
  }

  @override
  Future<bool> deleteScheduleNoTask(int scheduleId) async {
    String urlAPI = APIHelper.SCHEDULE_API + '/$scheduleId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.delete(urlAPI, headers: header);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 204) {
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<bool> updateSchedule(String scheduleUpdateJson) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.SCHEDULE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.put(urlAPI, headers: header, body: scheduleUpdateJson);

    if (response.statusCode == 200) {
      isSuccess = true;
    }

    return isSuccess;
  }

  @override
  Future<List<bool>> checkIsActiveOk(int doctorId) async {
    String urlAPI = APIHelper.SCHEDULE_API + '/Checking?doctorId=$doctorId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<bool> checkIsActive = [];

    if (response.statusCode == 200) {
      bool isCheckingStatus = json.decode(response.body)['isCheckingStatus'];
      bool isOvertime = json.decode(response.body)['isOvertime'];

      checkIsActive.add(isCheckingStatus);
      checkIsActive.add(isOvertime);

      return checkIsActive;
    } else
      return null;
  }
}
