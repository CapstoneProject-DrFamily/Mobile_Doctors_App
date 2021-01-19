import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class HomePageViewModel extends BaseModel {
  bool connecting = false;
  bool active = false;
  bool finding = false;

  isConnecting(bool connecting) {
    this.connecting = connecting;
    notifyListeners();
  }

  isActive(bool active) {
    this.active = active;
    notifyListeners();
  }

  isFinding(bool finding) {
    this.finding = finding;
    notifyListeners();
  }

  Future<bool> activeDoc() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<bool> loadPatient() async {
    await Future.delayed(Duration(seconds: 5));

    return true;
  }
}
