import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_detail_form.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';

class MedicineDetailFormViewModel extends BaseModel {
  //field in screen
  TextEditingController _medicineNameController = TextEditingController();
  TextEditingController get medicineNameController => _medicineNameController;
  TextEditingController _typeController = TextEditingController();
  TextEditingController get typeController => _typeController;
  TextEditingController _totalQuantityController = TextEditingController();
  TextEditingController get totalQuantityController => _totalQuantityController;
  TextEditingController _morningQuantityController = TextEditingController();
  TextEditingController get morningQuantityController =>
      _morningQuantityController;
  TextEditingController _noonQuantityController = TextEditingController();
  TextEditingController get noonQuantityController => _noonQuantityController;
  TextEditingController _afternoonQuantityController = TextEditingController();
  TextEditingController get afternoonQuantityController =>
      _afternoonQuantityController;
  TextEditingController _methodController = TextEditingController();
  TextEditingController get methodController => _methodController;

  bool _firstIn = false;

  MedicineDetailModel _detailForm;
  MedicineDetailModel get detailForm => _detailForm;

  Future<void> initMedicine(MedicineDetailModel varDetailForm) async {
    if (!_firstIn) {
      _detailForm = varDetailForm;
      _medicineNameController.text = _detailForm.medicineName;
      if (_detailForm.totalQuantity == null) {
        _totalQuantityController.text = null;
      } else {
        _totalQuantityController.text = _detailForm.totalQuantity.toString();
      }
      if (_detailForm.medicineType == null) {
        _typeController.text = null;
      } else {
        _typeController.text = _detailForm.medicineType;
      }
      if (_detailForm.morningQuantity == null) {
        _morningQuantityController.text = null;
      } else {
        _morningQuantityController.text =
            _detailForm.morningQuantity.toString();
      }
      if (_detailForm.noonQuantity == null) {
        _noonQuantityController.text = null;
      } else {
        _noonQuantityController.text = _detailForm.noonQuantity.toString();
      }
      if (_detailForm.afternoonQuantity == null) {
        _afternoonQuantityController.text = null;
      } else {
        _afternoonQuantityController.text =
            _detailForm.afternoonQuantity.toString();
      }
      if (_detailForm.medicineMethod == null) {
        _methodController.text = null;
      } else {
        _methodController.text = _detailForm.medicineMethod.toString();
      }
      notifyListeners();
      _firstIn = true;
    }
  }

  void addMedicine(BuildContext context) async {
    if (MedicineListViewModel.isUpdate) {
      MedicineListViewModel.listMedicine
        ..where((element) => element.medicineId == _detailForm.medicineId)
            .toList()
            .forEach((element) {
          element.totalQuantity = int.parse(_totalQuantityController.text);
          element.morningQuantity = int.parse(_morningQuantityController.text);
          element.noonQuantity = int.parse(_noonQuantityController.text);
          element.afternoonQuantity =
              int.parse(_afternoonQuantityController.text);
          element.medicineType = _typeController.text;
          element.medicineMethod = _methodController.text;
        });
    } else {
      MedicineDetailModel detailModel = MedicineDetailModel(
          medicineId: _detailForm.medicineId,
          medicineName: _detailForm.medicineName,
          totalQuantity: int.parse(_totalQuantityController.text),
          noonQuantity: int.parse(noonQuantityController.text),
          morningQuantity: int.parse(_morningQuantityController.text),
          afternoonQuantity: int.parse(_afternoonQuantityController.text),
          medicineMethod: _methodController.text,
          medicineType: _typeController.text);
      MedicineListViewModel.listMedicine.add(detailModel);
    }
    Navigator.pop(context);
  }
}
