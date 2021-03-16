import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';

abstract class IUserRepo {
  Future<int> getPhoneUser(int accountId);
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
}
