import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/test_timeline/analyze_refactor.dart';
import 'package:mobile_doctors_apps/screens/test_timeline/diagnose_refactor.dart';
import 'package:mobile_doctors_apps/screens/test_timeline/medicine_refactor.dart';
import 'package:mobile_doctors_apps/screens/test_timeline/sample_refactor.dart';

class TimeLineViewModel extends BaseModel {
  MedicineRefactor medicinePage;

  int index = 0;

  changeIndex(value) {
    this.index = value;
    notifyListeners();
  }

  Widget buildWidget(index, TimeLineViewModel model) {
    switch (index) {
      case 0:
        return AnalyzeRefactor(timelineModel: model);
      case 1:
        return SampleRefactor();
        break;
      case 2:
        return DiagnoseRefactor(timelineModel: model);
      case 3:
        this.medicinePage = new MedicineRefactor();
        return medicinePage;
      default:
    }
  }
}
