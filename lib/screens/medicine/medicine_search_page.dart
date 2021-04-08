import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_search_page_view_model.dart';

class MedicineSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineSearchPageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: TextField(
                controller: model.searchMedicine,
                decoration: InputDecoration(
                  hintText: "Search Data...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                onChanged: (query) => model.searchMedicineFunc(query),
              ),
              actions: [
                model.searchMedicine.text.isEmpty
                    ? Container()
                    : IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          model.searchMedicine.clear();
                        },
                      ),
              ],
            ),
            body: (() {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                );
              } else if (model.isNotHave) {
                return Center(
                  child: Text(
                    "Don't have this kind of medicine",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return ListView.builder(
                    controller: model.scrollController,
                    itemCount: (() {
                      if (model.changeList) {
                        if (!model.hasSearchNextPage) {
                          return model.listMedicineSearchModel.length;
                        } else {
                          return model.listMedicineSearchModel.length + 1;
                        }
                      } else {
                        if (!model.hasNextPage) {
                          return model.listMedicineModel.length;
                        } else {
                          return model.listMedicineModel.length + 1;
                        }
                      }
                    }()),
                    itemBuilder: (context, index) {
                      if (model.changeList) {
                        if (index == model.listMedicineSearchModel.length &&
                            model.hasSearchNextPage) {
                          return CupertinoActivityIndicator();
                        }
                      } else {
                        if (index == model.listMedicineModel.length &&
                            model.hasNextPage) {
                          print("equa");
                          return CupertinoActivityIndicator();
                        }
                      }
                      return InkWell(
                        onTap: () {
                          if (model.changeList) {
                            model.medicineDetail(
                                context,
                                model.listMedicineModel[index].medicineId,
                                '${model.listMedicineSearchModel[index].medicineName} - ${model.listMedicineSearchModel[index].medicineStrength}');
                          } else {
                            model.medicineDetail(
                                context,
                                model.listMedicineModel[index].medicineId,
                                '${model.listMedicineModel[index].medicineName} - ${model.listMedicineModel[index].medicineStrength}');
                          }
                        },
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/pills.svg',
                            width: 30,
                            height: 30,
                          ),
                          title: model.changeList
                              ? Text(
                                  '${model.listMedicineSearchModel[index].medicineName} - ${model.listMedicineSearchModel[index].medicineStrength}')
                              : Text(
                                  '${model.listMedicineModel[index].medicineName} - ${model.listMedicineModel[index].medicineStrength}'),
                        ),
                      );
                    });
              }
            }()));
      },
    );
  }
}
