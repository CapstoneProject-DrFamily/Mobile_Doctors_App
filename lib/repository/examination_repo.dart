import 'dart:convert';
import 'dart:io';

import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:http/http.dart' as http;

abstract class IExaminationRepo {
  Future<int> createNewExamination(String creator);
}

class ExaminationRepo extends IExaminationRepo {
  @override
  Future<int> createNewExamination(String creator) async {
    String urlAPI = APIHelper.Prefix_API + "/api/v1/ExaminationHistory";
    print(urlAPI);
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var data = {'insBy': creator, 'updBy': creator};
    print(data);

    var response =
        await http.post(urlAPI, headers: header, body: jsonEncode(data));
    if (response.statusCode == 201) {
      Map<String, dynamic> examination = jsonDecode(response.body);
      return examination['id'];
    } else
      return null;
  }
}
