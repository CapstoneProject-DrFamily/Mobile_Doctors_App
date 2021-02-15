import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/request_doctor_model.dart';

abstract class IDoctorRepo {
  Future<RequestDoctorModel> getSimpleInfo(int profileId);
}

class DoctorRepo extends IDoctorRepo {
  @override
  Future<RequestDoctorModel> getSimpleInfo(int profileId) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    print("in" + profileId.toString());
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/$profileId/SimpleInfo");
    var response = await http.get(uri, headers: header);
    print(response.statusCode);

    RequestDoctorModel doctorInfo;

    if (response.statusCode == 200) {
      Map<String, dynamic> doctorSimpleInfo = jsonDecode(response.body);
      doctorInfo = RequestDoctorModel.fromJson(doctorSimpleInfo);
      return doctorInfo;
    } else {
      return null;
    }
  }
}
