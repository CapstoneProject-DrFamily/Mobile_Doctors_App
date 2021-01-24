import 'package:mobile_doctors_apps/model/medicine.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class MedicineFormViewModel extends BaseModel {
  List<int> listCheck = List();

  List<Medicine> list = [
    Medicine(id: 1, name: 'Panadol'),
    Medicine(id: 2, name: 'Paracetamol'),
    Medicine(id: 3, name: 'Extra'),
    Medicine(id: 4, name: 'Eference 302'),
    Medicine(id: 5, name: '502 Keo'),
    Medicine(id: 6, name: '1234 Ngày'),
  ];

  void changeCheck(int id, bool isCheck) {
    if (isCheck) {
      if (!listCheck.contains(id)) {
        listCheck.add(id);
      }
    } else {
      listCheck.remove(id);
    }
    print(listCheck);

    notifyListeners();
  }
}
