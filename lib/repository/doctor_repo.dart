import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/doctor_detail.dart';
import 'package:mobile_doctors_apps/model/request_doctor_model.dart';
import 'package:mobile_doctors_apps/model/user_profile.dart';

abstract class IDoctorRepo {
  Future<RequestDoctorModel> getSimpleInfo(int profileId);
  Future<List<dynamic>> getDoctorDetail(int doctorId);
  Future<bool> updateDoctor(DoctorDetail doctorDetail);
  Future<int> getSpecialtyId(int doctorId);
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
      print("doctorInfo ${doctorInfo.doctorRatingPoint}");
      return doctorInfo;
    } else {
      return null;
    }
  }

  @override
  Future<List<dynamic>> getDoctorDetail(int doctorId) async {
    List list = [];
    String urlAPI = APIHelper.URI_PREFIX_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/$doctorId");
    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> doctorData = jsonDecode(response.body);
      DoctorDetail doctor = DoctorDetail.fromJson(doctorData);
      // UserProfile profile = UserProfile.fromJson(doctorData);
      list.add(doctor);
      // list.add(profile);
    }
    return list;
  }

  @override
  Future<bool> updateDoctor(DoctorDetail doctorDetail) async {
    bool isSuccess = false;
    String urlAPI = APIHelper.DOCTOR_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var response = await http.put(urlAPI,
        headers: header, body: jsonEncode(doctorDetail.toJson()));

    if (response.statusCode == 200) {
      isSuccess = true;
    }
    return isSuccess;
  }

  @override
  Future<int> getSpecialtyId(int doctorId) async {
    String urlAPI = APIHelper.URI_PREFIX_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var uri = Uri.http(urlAPI, "/api/v1/Doctors/$doctorId/SimpleInfo");
    var response = await http.get(uri, headers: header);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> doctorSimpleInfo = jsonDecode(response.body);
      int specialtyId = doctorSimpleInfo['doctorServiceId'];
      print('specialtyID $specialtyId');
      return specialtyId;
    } else {
      return null;
    }
  }
}
