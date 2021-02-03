import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/login/user_model.dart';

abstract class ISignInRepo {
  Future<UserModel> getLoginUser(String userName, String role);
}

class SignInRepo extends ISignInRepo {
  @override
  Future<UserModel> getLoginUser(String userName, String role) async {
    String apiSignIn = APIHelper.LOGIN_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    UserModel loginModel = new UserModel(userName: userName, role: role);

    String loginJson = jsonEncode(loginModel.toJson());

    http.Response response =
        await http.post(apiSignIn, headers: header, body: loginJson);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> userSampleInfo = jsonDecode(response.body);
      loginModel = UserModel.fromJson(userSampleInfo);
      return loginModel;
    } else {
      return null;
    }
  }
}
