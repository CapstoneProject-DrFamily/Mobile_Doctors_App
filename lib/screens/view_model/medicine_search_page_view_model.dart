import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/model/medicine_model.dart';
import 'package:mobile_doctors_apps/repository/medicine_repo.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_detail_form.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';

class MedicineSearchPageViewModel extends BaseModel {
  final IMedicineRepo _medicineRepo = MedicineRepo();

  TextEditingController _searchMedicine = TextEditingController();
  TextEditingController get searchMedicine => _searchMedicine;

  List<MedicineModel> _listMedicineModel;
  List<MedicineModel> get listMedicineModel => _listMedicineModel;

  PagingMedicineModel _pagingMedicineModel;
  PagingMedicineModel get pagingMedicineModel => _pagingMedicineModel;

  bool hasNextPage;
  bool hasSearchNextPage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  bool _changeList = false;
  bool get changeList => _changeList;

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  int _indexListMedicine = 1;
  int _indexSearchListMedicine = 1;

  List<MedicineModel> _listMedicineSearchModel;
  List<MedicineModel> get listMedicineSearchModel => _listMedicineSearchModel;

  String _searchValue;

  MedicineSearchPageViewModel() {
    _searchMedicine.addListener(() {
      if (_searchMedicine.text == "") {
        _changeList = false;
      }
      notifyListeners();
    });
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_changeList == true) {
          if (hasSearchNextPage) {
            _indexSearchListMedicine = _indexSearchListMedicine + 1;
            _pagingMedicineModel = await _medicineRepo.getPagingMedicine(
                _indexSearchListMedicine, 20, _searchValue);

            var moreListMedicine = _pagingMedicineModel.listMedicine;
            hasSearchNextPage = _pagingMedicineModel.hasNextPage;

            _listMedicineSearchModel = List.from(_listMedicineSearchModel)
              ..addAll(moreListMedicine);
            notifyListeners();
            print("get more data in searchList");
          } else {
            print("end data in searchList");
          }
        } else {
          if (hasNextPage) {
            _indexListMedicine = _indexListMedicine + 1;
            _pagingMedicineModel = await _medicineRepo.getPagingMedicine(
                _indexListMedicine, 20, null);
            var moreListMedicine = _pagingMedicineModel.listMedicine;
            hasNextPage = _pagingMedicineModel.hasNextPage;

            _listMedicineModel = List.from(_listMedicineModel)
              ..addAll(moreListMedicine);
            notifyListeners();
            print("get more data");
          } else {
            print("end data");
          }
        }
      }
    });
    initMedicineSearchPage();
  }

  void initMedicineSearchPage() async {
    _isLoading = true;
    _pagingMedicineModel =
        await _medicineRepo.getPagingMedicine(_indexListMedicine, 20, null);
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

  void searchMedicineFunc(String value) async {
    if (value.length >= 3) {
      _indexSearchListMedicine = 1;
      _isNotHave = false;
      _isLoading = true;
      _searchValue = value;
      _changeList = true;

      _pagingMedicineModel = await _medicineRepo.getPagingMedicine(
          _indexSearchListMedicine, 20, value);
      if (_pagingMedicineModel == null) {
        _isLoading = false;
        _isNotHave = true;
        notifyListeners();
        return;
      } else {
        _listMedicineSearchModel = _pagingMedicineModel.listMedicine;
        hasSearchNextPage = _pagingMedicineModel.hasNextPage;
        _isLoading = false;

        notifyListeners();
      }
    } else if (value.length == 0) {
      _changeList = false;
      notifyListeners();
    }
  }

  void medicineDetail(
      BuildContext context, int medicineID, String medicineName) {
    var medicine = MedicineListViewModel.listMedicine
        .where((element) => element.medicineId == medicineID);
    print(medicine);
    if (medicine.isEmpty) {
      MedicineDetailModel detailModel = MedicineDetailModel(
          medicineId: medicineID, medicineName: medicineName);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineDetailForm(
            detailModel: detailModel,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "This medicine has been added back to update",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
