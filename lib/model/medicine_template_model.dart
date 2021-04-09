import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';

class MedicineTemplateModel {
  String templateName, diseaseName, diseaseId;
  List<MedicineDetailModel> listMedicine;
  MedicineTemplateModel(
      {this.diseaseId, this.diseaseName, this.listMedicine, this.templateName});
}
