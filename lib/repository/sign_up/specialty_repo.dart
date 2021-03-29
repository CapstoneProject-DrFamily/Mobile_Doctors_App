import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/sign_up/specialty_sign_up_model.dart';

abstract class ISpecialtyRepo {
  Future<List<SpecialtyModel>> getAllSpecialty();
  Future<int> getServiceIdBySpecialtyId(int specialtyId);
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

  @override
  Future<int> getServiceIdBySpecialtyId(int specialtyId) async {
    String urlAPI = APIHelper.SPECIALTY_API + '/$specialtyId';
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);

    int serviceId;

    if (response.statusCode == 200) {
      Map<String, dynamic> specialtyJson = jsonDecode(response.body);
      serviceId = specialtyJson['services'][0]['serviceId'];
      print("serviceId $serviceId");
      return serviceId;
    } else
      return null;
  }
}
