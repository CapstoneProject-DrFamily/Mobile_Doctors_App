import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';

class PrescriptionModel {
  String prescriptionDes, insBy, updateBy, prescriptionId, diseaseId;
  List<MedicineDetailModel> listMedicine;

  PrescriptionModel(
      {this.insBy,
      this.listMedicine,
      this.prescriptionDes,
      this.updateBy,
      this.prescriptionId,
      this.diseaseId});

  Map<String, dynamic> toJson() => {
        "prescriptionId": prescriptionId,
        "description": prescriptionDes,
        "diseaseId": diseaseId,
        "insBy": insBy,
        "updBy": updateBy,
        "prescriptionDetails": listMedicine,
      };
}
