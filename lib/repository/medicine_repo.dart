import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/medicine_model.dart';

abstract class IMedicineRepo {
  Future<PagingMedicineModel> getPagingMedicine(
      int pageIndex, int pageSize, String searchValue);
}

class MedicineRepo extends IMedicineRepo {
  @override
  Future<PagingMedicineModel> getPagingMedicine(
      int pageIndex, int pageSize, String searchValue) async {
    String url;
    if (searchValue == null) {
      url = APIHelper.MEDICINE_API +
          '/paging?PageIndex=${pageIndex.toString()}&PageSize=${pageSize.toString()}';
    } else {
      url = APIHelper.MEDICINE_API +
          '/paging?PageIndex=${pageIndex.toString()}&PageSize=${pageSize.toString()}&SearchValue=$searchValue';
    }
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List<MedicineModel> _listMedicine = [];
      PagingMedicineModel _pagingMedicineModel;
      bool _hasNextPage;
      Map<String, dynamic> medicineJson = json.decode(response.body);
      // print('${medicineJson['medicines']}');

      _listMedicine = (medicineJson['medicines'] as List)
          .map((data) => MedicineModel.fromJson(data))
          .toList();
      _hasNextPage = medicineJson['hasNextPage'];
      print(_listMedicine.length);
      if (_listMedicine.length == 0) {
        return null;
      }
      _pagingMedicineModel = PagingMedicineModel(
          hasNextPage: _hasNextPage, listMedicine: _listMedicine);

      return _pagingMedicineModel;
    } else
      return null;
  }
}
