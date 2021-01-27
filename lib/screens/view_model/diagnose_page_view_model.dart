import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/Speciality.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class DiagnosePageViewModel extends BaseModel {
  List<Speciality> listSpeciality = [
    Speciality(name: 'Tim mạch', description: ""),
    Speciality(name: 'Hô hấp', description: ""),
    Speciality(name: 'Tiêu hóa', description: ""),
    Speciality(name: 'Tiết niệu', description: ""),
    Speciality(name: 'Cơ xương khớp', description: ""),
    Speciality(name: 'Nội tiết', description: ""),
    Speciality(name: 'Thần kinh', description: ""),
    Speciality(name: 'Tâm thần', description: ""),
    Speciality(name: 'Tai mũi họng', description: ""),
    Speciality(name: 'Răng hàm mặt', description: ""),
    Speciality(name: 'Mắt', description: ""),
    Speciality(name: 'Da liễu', description: ""),
    Speciality(name: 'Dinh dưỡng', description: ""),
    Speciality(name: 'Vận động', description: ""),
    Speciality(name: 'Khác', description: ""),
    Speciality(
        name: 'Đánh giá phát triển thể chất, tinh thần, vận động',
        description: ""),
  ];

  DiagnosePageViewModel() {
    print('is reload again');
  }

  // List<String> listCheck = List();

  bool change = false;

  void changed(bool value) {
    this.change = value;
    notifyListeners();
  }

  void changeCheck(String name, bool isCheck, List listCheck) {
    if (isCheck) {
      if (!listCheck.contains(name)) {
        listCheck.add(name);
      }
    } else {
      listCheck.remove(name);
    }
    notifyListeners();
  }
}
