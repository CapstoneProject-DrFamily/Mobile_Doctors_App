import 'package:mobile_doctors_apps/model/patient_model.dart';
import 'package:mobile_doctors_apps/repository/patient_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class PopupInfoPatientPage extends BaseModel {
  final IPatientRepo _patientRepo = PatientRepo();

  bool _isFirstPopUp = true;
  bool get isFirstPopUp => _isFirstPopUp;

  bool _isLoadingPopUp = true;
  bool get isLoadingPopUp => _isLoadingPopUp;

  PatientModel patientModel;

  Future<void> initInfoPatient(int patientId) async {
    if (_isFirstPopUp) {
      patientModel = await _patientRepo.getPatientInfo(patientId);
      _isLoadingPopUp = false;
      _isFirstPopUp = false;
      notifyListeners();
    }
  }
}
