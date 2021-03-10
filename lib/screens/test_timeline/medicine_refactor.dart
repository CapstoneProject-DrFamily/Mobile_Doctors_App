import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class MedicineRefactor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineListViewModel>(builder: (context, child, model) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/images/medicinelist.jpg'),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Stack(
                      alignment: Alignment.topCenter,
                      overflow: Overflow.visible,
                      children: [
                        MedicineFormDetail(
                          model: model,
                        ),
                        Visibility(
                          visible: !model.keyboard ? true : false,
                          child: Positioned(
                            top: -66,
                            child: CircleAvatar(
                              radius: 73,
                              backgroundColor:
                                  MainColors.blueBegin.withOpacity(0.5),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70,
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/time_line_4.png',
                                    width: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !model.keyboard ? true : false,
                          child: Positioned(
                              bottom: 10,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      color:
                                          MainColors.blueBegin.withOpacity(0.8),
                                      onPressed: () async {
                                        model.finishTransaction(context);
                                      },
                                      child: Text(
                                        'Finish',
                                        style: TextStyle(fontSize: 20),
                                      )),
                                ),
                              )),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.addMedicine(context);
          },
          child: SvgPicture.asset(
            'assets/icons/pills.svg',
            height: 30,
            width: 30,
          ),
          backgroundColor: Colors.lightBlue[100],
        ),
      );
    });
  }
}
