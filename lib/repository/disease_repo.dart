import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/api_helper.dart';
import 'package:mobile_doctors_apps/model/disease_model.dart';

abstract class IDiseaseRepo {
  Future<PagingDiseaseModel> getPagingDisease(
      int pageIndex, int pageSize, String searchValue);
}

class DiseaseRepo extends IDiseaseRepo {
  @override
  Future<PagingDiseaseModel> getPagingDisease(
      int pageIndex, int pageSize, String searchValue) async {
    String url;
    if (searchValue == null) {
      url = APIHelper.DISEASE_API +
          '/paging?PageIndex=${pageIndex.toString()}&PageSize=${pageSize.toString()}';
    } else {
      url = APIHelper.DISEASE_API +
          '/paging?PageIndex=${pageIndex.toString()}&PageSize=${pageSize.toString()}&SearchValue=$searchValue';
    }

    print("url $url");
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List<DiseaseModel> _listDiseaseModel = [];
      PagingDiseaseModel _pagingDiseaseModel;
      bool _hasNextPage;
      Map<String, dynamic> diseaseJson = json.decode(response.body);
      // print('${diseaseJson['diseases']}');

      _listDiseaseModel = (diseaseJson['diseases'] as List)
          .map((data) => DiseaseModel.fromJson(data))
          .toList();
      _hasNextPage = diseaseJson['hasNextPage'];
      print(_listDiseaseModel.length);
      if (_listDiseaseModel.length == 0) {
        return null;
      }
      _pagingDiseaseModel = PagingDiseaseModel(
          hasNextPage: _hasNextPage, listDisease: _listDiseaseModel);

      return _pagingDiseaseModel;
    } else
      return null;
  }
}
