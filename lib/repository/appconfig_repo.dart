import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/model/medicine_template_model.dart';

abstract class IAppConfigRepo {
  Future<int> appConfigTimeOut();
  Future<List<MedicineTemplateModel>> appConfigPrescriptionTemplate();
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

  @override
  Future<List<MedicineTemplateModel>> appConfigPrescriptionTemplate() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    List<MedicineTemplateModel> listTemplate = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonConfigPrescription =
          json.decode(response.body)['prescriptionTemplates'];
      for (String key in jsonConfigPrescription.keys) {
        print('key $key');
        List<MedicineDetailModel> listMedicineInFrom = [];

        listMedicineInFrom =
            (jsonConfigPrescription[key]['prescriptionDetails'] as List)
                .map((data) => MedicineDetailModel.fromJson(data))
                .toList();
        MedicineTemplateModel templateModel = MedicineTemplateModel(
            diseaseId: jsonConfigPrescription[key]['diseaseId'],
            diseaseName: jsonConfigPrescription[key]['description'],
            listMedicine: listMedicineInFrom,
            templateName: key);
        listTemplate.add(templateModel);
      }

      print('template: ${listTemplate[0].listMedicine[0].medicineName}');
      return listTemplate;
    } else {
      return null;
    }
  }
}
