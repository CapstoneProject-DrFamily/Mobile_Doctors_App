import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';

abstract class ISignUpRepo {
  Future<bool> createDoctorProfile(String createDoctorProfileJson);
}

class SignUpRepo extends ISignUpRepo {
  @override
  Future<bool> createDoctorProfile(String createDoctorProfileJson) async {
    String urlAPI = APIHelper.DOCTOR_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: createDoctorProfileJson);
    print("Status code: " + response.statusCode.toString());
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
