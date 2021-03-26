import 'package:mobile_doctors_apps/model/patient_transacion/patient_prescription_model.dart';
import 'package:mobile_doctors_apps/repository/prescription_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class TransactionPrescriptionViewModel extends BaseModel {
  bool init = true;
  List<PatientPrescriptionModel> list;
  IPrescriptionRepo _prescriptionRepo = PrescriptionRepo();
  String description;

  fetchData(String transactionId) async {
    if (init) {
      List<dynamic> result =
          await _prescriptionRepo.getPrescriptionDetail(transactionId);
      list = result[0];
      description = result[1];
      print(description);

      this.init = false;
      notifyListeners();
    }
  }
}
