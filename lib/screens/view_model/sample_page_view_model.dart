import 'package:mobile_doctors_apps/model/blood_test_parameter.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_pop_up_view_model.dart';

class SamplePageViewModel extends BaseModel {
  List<BloodTestParameter> listParameter = [];

  List<BloodParameter> listCheck = [];

  void loadParameter(List<BloodParameter> list) {
    bool isExisted;
    list.forEach((element) {
      if (element.isCheck) {
        isExisted = false;
        listCheck.forEach((item) {
          if (item.name == element.name) {
            isExisted = true;
          }
        });
        if (!isExisted) {
          BloodTestParameter params = BloodTestParameter(
              name: element.name, result: 0.0, normal: element.normal);
          listParameter.add(params);
          listCheck.add(element);
        }
      } else {
        listCheck.removeWhere((t) => t.name == element.name);
        listParameter.removeWhere((t) => t.name == element.name);
      }
    });

    notifyListeners();
  }

  // List<String> listCheck = [];

  // void changeCheck(String name, bool isCheck) {
  //   if (isCheck) {
  //     if (!listCheck.contains(name)) {
  //       listCheck.add(name);
  //     }
  //   } else {
  //     listCheck.remove(name);
  //   }

  //   notifyListeners();
  // }
}
