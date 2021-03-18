import 'dart:convert';
import 'dart:io';

import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/model/examination_history.dart';

abstract class IExaminationRepo {
  Future<String> createNewExamination(String transactionID, String creator);
  Future<ExaminationHistory> getExaminationHistory(String examID);
  Future<bool> updateExaminationHistory(String examinationJson);
}

class ExaminationRepo extends IExaminationRepo {
  @override
  Future<String> createNewExamination(
      String transactionID, String creator) async {
    String urlAPI = APIHelper.Prefix_API + "/api/v1/ExaminationHistory";
    print(urlAPI);
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var data = {'id': transactionID, 'insBy': creator, 'updBy': creator};
    print(data);

    var response =
        await http.post(urlAPI, headers: header, body: jsonEncode(data));
    if (response.statusCode == 201) {
      Map<String, dynamic> examination = jsonDecode(response.body);
      return examination['id'];
    } else
      return null;
  }

  @override
  Future<ExaminationHistory> getExaminationHistory(String examID) async {
    String url = APIHelper.EXAMINATIONHISTORY_API + '/${examID.toString()}';

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(url, headers: header);

    ExaminationHistory examinationHistory;

    if (response.statusCode == 200) {
      Map<String, dynamic> examinationJson = json.decode(response.body);
      examinationHistory = ExaminationHistory.fromJson(examinationJson);
      return examinationHistory;
    } else
      return null;
  }

  @override
  Future<bool> updateExaminationHistory(String examinationJson) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.EXAMINATIONHISTORY_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response1 =
        await http.put(urlAPI, headers: header, body: examinationJson);

    if (response1.statusCode == 200) {
      isSuccess = true;
    }

    return isSuccess;
  }
}
