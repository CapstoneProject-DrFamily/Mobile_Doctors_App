import 'package:mobile_doctors_apps/model/blood_test_parameter.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class SamplePopUpViewModel extends BaseModel {
  List<BloodParameter> listParameter = [
    BloodParameter(name: 'WBC', isCheck: false, normal: "(4.0 ~ 10.0)"),
    BloodParameter(name: 'RBC', isCheck: false, normal: "(3.99 ~ 6.01)"),
    BloodParameter(name: 'HGB', isCheck: false, normal: "(1.99 ~ 6.01)"),
  ];

  void loadParameter(List<BloodParameter> list) {
    list.forEach((element) {
      listParameter.forEach((item) {
        if (element.name == item.name) {
          item.isCheck = element.isCheck;
        }
      });
    });
  }

  void changeCheck(String name, bool isCheck) {
    print(isCheck);
    listParameter.forEach((element) {
      if (element.name == name) {
        element.isCheck = isCheck;
      }
    });

    notifyListeners();
  }
}

class BloodParameter {
  String name;
  bool isCheck;
  String normal;

  BloodParameter({this.name, this.isCheck, this.normal});
}
