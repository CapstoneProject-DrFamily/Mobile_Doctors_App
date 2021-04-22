import 'package:mobile_doctors_apps/repository/appconfig_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class PolicyViewModel extends BaseModel {
  bool init = true;
  String htmlData;
  AppConfigRepo _appConfigRepo = AppConfigRepo();
  fetchPolicy() async {
    if (init) {
      this.htmlData = await _appConfigRepo.getPolicy();
      init = false;
      notifyListeners();
    }
  }
}
