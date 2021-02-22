import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/sign_up/specialty_sign_up_model.dart';

abstract class ISpecialtyRepo {
  Future<List<SpecialtyModel>> getAllSpecialty();
}

class SpecialtyRepo extends ISpecialtyRepo {
  @override
  Future<List<SpecialtyModel>> getAllSpecialty() async {
    String urlAPI = APIHelper.SPECIALTY_API;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    List<SpecialtyModel> listSpecialty;

    if (response.statusCode == 200) {
      listSpecialty = (json.decode(response.body) as List)
          .map((data) => SpecialtyModel.fromJson(data))
          .toList();
      return listSpecialty;
    } else
      return null;
  }
}
