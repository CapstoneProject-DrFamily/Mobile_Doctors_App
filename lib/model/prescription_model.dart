import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';

class PrescriptionModel {
  String prescriptionDes, insBy, updateBy;
  List<MedicineDetailModel> listMedicine;

  PrescriptionModel(
      {this.insBy, this.listMedicine, this.prescriptionDes, this.updateBy});

  Map<String, dynamic> toJson() => {
        "description": prescriptionDes,
        "insBy": insBy,
        "updBy": updateBy,
        "prescriptionDetails": listMedicine,
      };
}
