import 'package:mobile_doctors_apps/model/health_record_model.dart';
import 'package:mobile_doctors_apps/repository/health_recrod_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class ListOldHealthRecordViewModel extends BaseModel {
  final IHealthRecordRepo _healthRecordRepo = HealthRecordRepo();
  HealthRecordModel _healthRecordModel;
  int patientID, healthRecordID;

  List<HealthRecordModel> _listOldHealthRecord = [];
  List<HealthRecordModel> get listOldHealthRecord => _listOldHealthRecord;

  bool init = true;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> getListOldPersonalHealthRecord(int patientID) async {
    if (init) {
      this.patientID = patientID;
      _listOldHealthRecord =
          await _healthRecordRepo.getListOldHealthRecord(patientID, true);
      this.init = false;
      this._isLoading = false;
    }
  }
}
