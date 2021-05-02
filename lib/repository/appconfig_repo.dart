import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/model/medicine_template_model.dart';

abstract class IAppConfigRepo {
  Future<int> appConfigTimeOut();
  Future<List<MedicineTemplateModel>> appConfigPrescriptionTemplate();
  Future<String> getPolicy();
  Future<int> getNumberofImage();
  Future<int> getMinuteToClick();
  Future<int> getEstimateTime();
  Future<double> getGapTimeSchedule();
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
        List<MedicineDetailModel> listMedicineInFromDisplay = [];

        listMedicineInFrom =
            (jsonConfigPrescription[key]['prescriptionDetails'] as List)
                .map((data) => MedicineDetailModel.fromJson(data))
                .toList();

        print("list ${listMedicineInFrom.length}");
        for (var item in listMedicineInFrom) {
          MedicineDetailModel model = MedicineDetailModel(
              afternoonQuantity: item.afternoonQuantity,
              medicineId: item.medicineId,
              medicineMethod: item.medicineMethod,
              medicineName: item.medicineName,
              medicineType: item.medicineType,
              morningQuantity: item.morningQuantity,
              noonQuantity: item.noonQuantity,
              totalDays: item.totalDays,
              totalQuantity: (item.morningQuantity +
                      item.noonQuantity +
                      item.afternoonQuantity) *
                  item.totalDays);
          listMedicineInFromDisplay.add(model);
        }

        print("total ${listMedicineInFromDisplay[0].totalQuantity}");

        MedicineTemplateModel templateModel = MedicineTemplateModel(
            diseaseId: jsonConfigPrescription[key]['diseaseId'],
            diseaseName: jsonConfigPrescription[key]['description'],
            listMedicine: listMedicineInFromDisplay,
            templateName: key);
        listTemplate.add(templateModel);
      }

      print('template: ${listTemplate[0].listMedicine[0].medicineName}');
      return listTemplate;
    } else {
      return null;
    }
  }

  @override
  Future<String> getPolicy() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['policy'];
    } else
      return null;
  }

  @override
  Future<int> getNumberofImage() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['imageQuantity'];
    } else
      return null;
  }

  @override
  Future<int> getMinuteToClick() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['appointmentNotifyTime'];
    } else
      return null;
  }

  @override
  Future<int> getEstimateTime() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['minusTimeInMinute'];
    } else
      return null;
  }

  @override
  Future<double> getGapTimeSchedule() async {
    String urlAPI = APIHelper.APP_CONFIG;
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['examinationHour'];
    } else
      return null;
  }
}
