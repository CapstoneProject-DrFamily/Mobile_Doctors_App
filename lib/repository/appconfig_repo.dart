import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';

abstract class IAppConfigRepo {
  Future<int> appConfigTimeOut();
}

class AppConfigRepo extends IAppConfigRepo {
  @override
  Future<int> appConfigTimeOut() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    if (response.statusCode == 200) {
      int timeOut = json.decode(response.body)['timeout'];
      return timeOut;
    } else {
      return null;
    }
  }
}
