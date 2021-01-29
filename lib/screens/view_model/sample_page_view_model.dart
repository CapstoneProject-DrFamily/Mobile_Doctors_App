import 'package:mobile_doctors_apps/model/blood_test_parameter.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class SamplePageViewModel extends BaseModel {
  List<BloodTestParameter> listParameter = [
    BloodTestParameter(name: 'WBC', result: 0, normal: '(4.0 ~ 10.0)'),
    BloodTestParameter(name: 'RBC', result: 0, normal: '(3.9 ~ 6.01)'),
    BloodTestParameter(name: 'HGB', result: 0, normal: '(4.0 ~ 10.0)'),
  ];

  List<BloodTestParameter> listCheck = [];

  SamplePageViewModel() {
    print('sa');
  }
}
