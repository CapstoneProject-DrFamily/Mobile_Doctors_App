import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/model/medicine.dart';
import 'package:mobile_doctors_apps/model/medicine_model.dart';
import 'package:mobile_doctors_apps/repository/medicine_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class MedicineFormViewModel extends BaseModel {
  final IMedicineRepo _medicineRepo = MedicineRepo();

  List<int> listCheck = [];

  List<Medicine> list = [
    Medicine(id: 1, name: 'Panadol'),
    Medicine(id: 2, name: 'Paracetamol'),
    Medicine(id: 3, name: 'Extra'),
    Medicine(id: 4, name: 'Eference 302'),
    Medicine(id: 5, name: '502 Keo'),
    Medicine(id: 6, name: '1234 Ngày'),
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  List<MedicineModel> _listMedicineModel;
  List<MedicineModel> get listMedicineModel => _listMedicineModel;

  PagingMedicineModel _pagingMedicineModel;
  PagingMedicineModel get pagingMedicineModel => _pagingMedicineModel;

  bool hasNextPage;

  bool keyboard = false;

  MedicineFormViewModel() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboard = visible;
        Future.delayed(const Duration(seconds: 2), () {});

        notifyListeners();
      },
    );
    print('again');
    initMedicineForm();
  }

  Future<void> initMedicineForm() async {
    _isLoading = true;
    _pagingMedicineModel = await _medicineRepo.getPagingMedicine(1, 5, null);
    if (_pagingMedicineModel == null) {
      _isNotHave = true;
      _isLoading = false;
      notifyListeners();
      return;
    } else {
      _listMedicineModel = _pagingMedicineModel.listMedicine;
      hasNextPage = _pagingMedicineModel.hasNextPage;

      _isLoading = false;
      notifyListeners();
    }
  }

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
