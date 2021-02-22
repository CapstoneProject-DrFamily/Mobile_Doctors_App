import 'dart:convert';
import 'dart:io';
import 'package:commons/commons.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/sign_up/update_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISignUpRepo {
  Future<bool> createProfile(String createProfileJson);
  Future<bool> updateUser();
  Future<bool> createDoctor(String createDoctorJson);
}

class SignUpRepo extends ISignUpRepo {
  UpdateUserModel _updateUserModel;
  int profileId, accountId, healthRecordId;
  String phone, formatPhone;

  @override
  Future<bool> createProfile(String createProfileJson) async {
    String urlAPI = APIHelper.CREATE_PROFILE_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: createProfileJson);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 201) {
      String jSonData = response.body;
      var decodeData = jsonDecode(jSonData);
      profileId = decodeData["profileId"];

      print("ProfileId: " + profileId.toString());
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }

  @override
  Future<bool> updateUser() async {
    String urlAPI = APIHelper.UPDATE_USER_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("usProfileID", profileId);
    phone = sharedPreferences.getString('usPhone');
    accountId = sharedPreferences.getInt('usAccountID');
    formatPhone = phone.replaceFirst("0", "84");

    _updateUserModel = new UpdateUserModel(
        disable: 0,
        updBy: phone,
        updDatetime: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        accountId: accountId,
        username: formatPhone,
        password: null,
        roleId: 2,
        profileId: profileId,
        waiting: 1);

    String updateUserJson = jsonEncode(_updateUserModel.toJson());
    print("UpdUserJson: " + updateUserJson);

    var response =
        await http.put(urlAPI, headers: header, body: updateUserJson);

    print("Status code: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }

  @override
  Future<bool> createDoctor(String createDoctorJson) async {
    String urlAPI = APIHelper.CREATE_DOCTOR_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response =
        await http.post(urlAPI, headers: header, body: createDoctorJson);
    print("Status code: " + response.statusCode.toString());
    bool isCreated = true;

    if (response.statusCode == 201) {
      return isCreated;
    } else {
      isCreated = false;
      return isCreated;
    }
  }
}
