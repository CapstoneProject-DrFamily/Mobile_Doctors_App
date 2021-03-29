import 'package:flutter/cupertino.dart';
import 'package:mobile_doctors_apps/helper/validate.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';

class MedicineDetailFormViewModel extends BaseModel {
  //field in screen
  TextEditingController _medicineTotalDays = TextEditingController();
  TextEditingController get medicineTotalDays => _medicineTotalDays;
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

  bool isValidQuantity = false;
  bool isValidType = false;

  Future<void> initMedicine(MedicineDetailModel varDetailForm) async {
    if (!_firstIn) {
      _medicineTotalDays.addListener(() {
        int totalDays = (_medicineTotalDays.text.isEmpty)
            ? 0
            : int.parse(_medicineTotalDays.text);
        int morningQuantity = (_morningQuantityController.text.isEmpty)
            ? 0
            : int.parse(_morningQuantityController.text);
        int noonQuantity = (_noonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_noonQuantityController.text);
        int afternoonQuantity = (_afternoonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_afternoonQuantityController.text);

        int total =
            (morningQuantity + noonQuantity + afternoonQuantity) * totalDays;
        totalQuantityController.text = total.toString();
        notifyListeners();
      });
      _typeController.addListener(() {
        if (_typeController.text.isEmpty)
          isValidType = false;
        else {
          try {
            int.parse(_typeController.text);

            isValidType = false;
          } catch (e) {
            print("oke");
            isValidType = true;
          }
        }
        print('valid Type $isValidType');

        notifyListeners();
      });
      _totalQuantityController.addListener(() {
        notifyListeners();
      });
      _morningQuantityController.addListener(() {
        if (_morningQuantityController.text.isEmpty ||
            int.parse(_morningQuantityController.text) < 1) {
          isValidQuantity = false;
        } else {
          isValidQuantity = true;
        }

        int totalDays = (_medicineTotalDays.text.isEmpty)
            ? 0
            : int.parse(_medicineTotalDays.text);
        int morningQuantity = (_morningQuantityController.text.isEmpty)
            ? 0
            : int.parse(_morningQuantityController.text);
        int noonQuantity = (_noonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_noonQuantityController.text);
        int afternoonQuantity = (_afternoonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_afternoonQuantityController.text);

        int total =
            (morningQuantity + noonQuantity + afternoonQuantity) * totalDays;
        totalQuantityController.text = total.toString();
        notifyListeners();
      });
      _noonQuantityController.addListener(() {
        if (_noonQuantityController.text.isEmpty ||
            int.parse(_noonQuantityController.text) < 1) {
          isValidQuantity = false;
        } else {
          isValidQuantity = true;
        }

        int totalDays = (_medicineTotalDays.text.isEmpty)
            ? 0
            : int.parse(_medicineTotalDays.text);
        int morningQuantity = (_morningQuantityController.text.isEmpty)
            ? 0
            : int.parse(_morningQuantityController.text);
        int noonQuantity = (_noonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_noonQuantityController.text);
        int afternoonQuantity = (_afternoonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_afternoonQuantityController.text);

        int total =
            (morningQuantity + noonQuantity + afternoonQuantity) * totalDays;
        totalQuantityController.text = total.toString();
        notifyListeners();
      });
      _afternoonQuantityController.addListener(() {
        if (_afternoonQuantityController.text.isEmpty ||
            int.parse(_afternoonQuantityController.text) < 1) {
          isValidQuantity = false;
        } else {
          isValidQuantity = true;
        }
        int totalDays = (_medicineTotalDays.text.isEmpty)
            ? 0
            : int.parse(_medicineTotalDays.text);
        int morningQuantity = (_morningQuantityController.text.isEmpty)
            ? 0
            : int.parse(_morningQuantityController.text);
        int noonQuantity = (_noonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_noonQuantityController.text);
        int afternoonQuantity = (_afternoonQuantityController.text.isEmpty)
            ? 0
            : int.parse(_afternoonQuantityController.text);

        int total =
            (morningQuantity + noonQuantity + afternoonQuantity) * totalDays;
        totalQuantityController.text = total.toString();
        notifyListeners();
      });

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
      if (_detailForm.totalDays == null) {
        _medicineTotalDays.text = null;
      } else {
        _medicineTotalDays.text = _detailForm.totalDays.toString();
      }

      notifyListeners();
      _firstIn = true;
    }
  }

  void addMedicine(BuildContext context) async {
    bool isValid = false;
    if (_totalQuantityController.text.isEmpty ||
        int.parse(_totalQuantityController.text) < 1) {
      isValid = false;
    } else if (!isValidType) {
      isValid = false;
    } else if (!isValidQuantity) {
      isValid = false;
    } else {
      isValid = true;
    }

    if (isValid) {
      if (MedicineListViewModel.isUpdate) {
        MedicineListViewModel.listMedicine
          ..where((element) => element.medicineId == _detailForm.medicineId)
              .toList()
              .forEach((element) {
            element.totalQuantity = int.parse(_totalQuantityController.text);
            element.morningQuantity = (_morningQuantityController.text.isEmpty)
                ? 0
                : int.parse(_morningQuantityController.text);
            element.noonQuantity = (_noonQuantityController.text.isEmpty)
                ? 0
                : int.parse(_noonQuantityController.text);
            element.afternoonQuantity =
                (afternoonQuantityController.text.isEmpty)
                    ? 0
                    : int.parse(_afternoonQuantityController.text);
            element.medicineType = _typeController.text;
            element.medicineMethod = _methodController.text;
            element.totalDays = int.parse(_medicineTotalDays.text);
          });
      } else {
        MedicineDetailModel detailModel = MedicineDetailModel(
            totalDays: int.parse(_medicineTotalDays.text),
            medicineId: _detailForm.medicineId,
            medicineName: _detailForm.medicineName,
            totalQuantity: int.parse(_totalQuantityController.text),
            noonQuantity: (_noonQuantityController.text.isEmpty)
                ? 0
                : int.parse(noonQuantityController.text),
            morningQuantity: (_morningQuantityController.text.isEmpty)
                ? 0
                : int.parse(_morningQuantityController.text),
            afternoonQuantity: (afternoonQuantityController.text.isEmpty)
                ? 0
                : int.parse(_afternoonQuantityController.text),
            medicineMethod: _methodController.text,
            medicineType: _typeController.text);
        MedicineListViewModel.listMedicine.add(detailModel);
      }
      Navigator.pop(context);
    } else {
      print("ERROR");
    }
  }
}
