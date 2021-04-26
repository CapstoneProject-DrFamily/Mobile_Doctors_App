import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/user_update_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserRepo {
  Future<int> getPhoneUser(int accountId);
  Future<bool> updateUser(String tokenNoti);
}

class UserRepo extends IUserRepo {
  @override
  Future<int> getPhoneUser(int accountId) async {
    String urlAPI = APIHelper.UPDATE_USER_API + '/$accountId';

    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> userJson = jsonDecode(response.body);
      var phone = userJson['username'];
      return int.parse(phone);
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateUser(String tokenNoti) async {
    String urlAPI = APIHelper.UPDATE_USER_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String phone = prefs.getString('usPhone');
    int accountId = prefs.getInt('usAccountID');
    String formatPhone = phone.replaceFirst("0", "84");

    UserUpdateModel _updateUserModel = new UserUpdateModel(
        disable: 0,
        updBy: phone,
        updDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        accountId: accountId,
        username: formatPhone,
        password: null,
        roleId: 3,
        waiting: 0,
        notiToken: tokenNoti);

    // String updateUserJson = jsonEncode(_updateUserModel.toJson());
    var data = {
      'userModel': {
        "disable": 0,
        "updBy": phone,
        "updDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "accountId": accountId,
        "username": formatPhone,
        "password": null,
        "roleId": 3,
        "waiting": 0,
        "notiToken": tokenNoti,
      }
    };
    print("UpdUserJson: " + jsonEncode(data));

    var response =
        await http.put(urlAPI, headers: header, body: jsonEncode(data));

    print("Status code: " + response.statusCode.toString());

    bool isUpdated = true;
    if (response.statusCode == 200) {
      return isUpdated;
    } else {
      isUpdated = false;
      return isUpdated;
    }
  }
}
