import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mobile_doctors_apps/screens/medicine/medicine_search_bar.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_form_view_model.dart';

class MedicineForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineFormViewModel>(builder: (context, child, model) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: SearchMedicineBar(),
                ),
                SizedBox(height: 20),
                Container(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: model.list.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/icons/pills.svg',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      model.list[index].name,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Checkbox(
                                                value: model.listCheck.contains(
                                                        model.list[index].id)
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  model.changeCheck(
                                                      model.list[index].id,
                                                      value);
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                    Visibility(
                                      visible: model.listCheck
                                          .contains(model.list[index].id),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .lightBlue[100]
                                                          .withOpacity(0.8),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Sáng ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        Expanded(
                                                          child: Container(
                                                            child: TextField(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ]),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          'viên',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Trưa ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        Expanded(
                                                          child: Container(
                                                            child: TextField(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ]),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          'viên',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Chiều ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        Expanded(
                                                          child: Container(
                                                            child: TextField(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ]),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          'viên',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          'Tổng ',
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        Expanded(
                                                          child: Container(
                                                            child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .digitsOnly
                                                                ]),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                          'ngày',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: -10,
                                              left: 20,
                                              child: Container(
                                                color: Colors.white,
                                                child: Text(
                                                  'Details',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }
}
