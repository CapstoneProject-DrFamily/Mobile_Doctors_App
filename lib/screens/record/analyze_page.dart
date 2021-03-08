import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:mobile_doctors_apps/helper/StatefulWrapper.dart';
import 'package:mobile_doctors_apps/screens/record/sample_page.dart';

import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/analyze_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class AnalyzePage extends StatelessWidget {
  List<String> listCheck = List();
  bool keyboardOn = false;
  int _processIndex = 0;

  final String transactionId;
  AnalyzePage({@required this.transactionId});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return BaseView<AnalyzePageViewModel>(
      builder: (context, child, model) {
        return StatefulWrapper(
          onInit: () {
            KeyboardVisibilityNotification().addNewListener(
              onChange: (bool visible) {
                keyboardOn = visible;
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/images/diagnose.jpg'),
                )),
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: MainColors.blueBegin),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: timelineProcess(context, _processIndex),
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        MainColors.blueBegin.withOpacity(0.6),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.65,
                                child: Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 100, 0, 0),
                                    child: SingleChildScrollView(
                                      child: buildAnalyzeForm(
                                          MediaQuery.of(context).size, model),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !keyboardOn ? true : false,
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
                                          'assets/images/time_line_1.png',
                                          width: 120,
                                          // color: Colors.red,
                                        ),

                                        // SvgPicture.asset(
                                        //   'assets/icons/medical-file.svg',
                                        //   height: 80,
                                        //   width: 80,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !keyboardOn ? true : false,
                                child: Positioned(
                                    bottom: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            color: MainColors.blueBegin
                                                .withOpacity(0.8),
                                            onPressed: () async {
                                              bool isSuccess = await model
                                                  .createExaminationForm(
                                                      transactionId);
                                              if (isSuccess) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SamplePage()));
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Error. Please try again",
                                                  textColor: Colors.red,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  gravity: ToastGravity.CENTER,
                                                );
                                              }
                                            },
                                            child: Text('Next')),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildAnalyzeForm(Size size, AnalyzePageViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildMedicalHistory(size, model),
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width * 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: buildExamination(model),
          ),
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Container buildMedicalHistory(Size size, AnalyzePageViewModel model) {
    return Container(
      width: size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '1. Medical History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white.withOpacity(0.8),
                  alignment: Alignment.topCenter,
                  width: size.width * 0.8,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Enter medical history of patient'),
                    onChanged: (value) {
                      model.examinationForm.history = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildExamination(AnalyzePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '2. Thăm khám lâm sàng',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2.1 ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      'Dấu hiệu sinh tồn, chỉ số nhân trắc học',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildAnthropometricIndex("Mạch", "nhịp/phút", model, "pulseRate"),
            buildAnthropometricIndex("Nhiệt độ", "độ C", model, "temperature"),
            buildAnthropometricIndex("Huyết áp", "...", model, "bloodPressure"),
            buildAnthropometricIndex(
                "Nhịp thở", "...", model, "respiratoryRate"),
            buildAnthropometricIndex("Cân nặng", "kg", model, "weight"),
            buildAnthropometricIndex("Chiều cao", "cm", model, "height"),
            buildAnthropometricIndex("BMI", "...", model, "BMI"),
            buildAnthropometricIndex(
                "Vòng bụng", "...", model, "waistCircumference"),
          ],
        ),
        Divider(
          thickness: 0.5,
          color: MainColors.blueBegin,
        ),
        buildEyeSight(model),
        Divider(
          thickness: 0.5,
          color: MainColors.blueBegin,
        ),
        buildBody(model),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    '2.3.2 ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      'Cơ quan',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(model.listSpeciality.length, (index) {
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    model.listSpeciality[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: listCheck.contains(
                                      model.listSpeciality[index].name)
                                  ? true
                                  : false,
                              onChanged: (value) {
                                print(value);

                                model.changeCheck(
                                    model.listSpeciality[index].name,
                                    value,
                                    listCheck,
                                    index,
                                    model);
                              },
                            ),
                          )
                        ],
                      )),
                    ),
                    Visibility(
                      visible:
                          listCheck.contains(model.listSpeciality[index].name),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                model.changeFieldText(index, model, value);
                              },
                              maxLines: 3,
                              decoration: InputDecoration(
                                  hintText: 'Enter text',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Column buildBody(AnalyzePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.3 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Khám lâm sàng',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              Text(
                '2.3.1 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Toàn thân',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Da, niêm mạc',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              model.examinationForm.mucosa = value;
            },
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Khác',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              model.examinationForm.otherBody = value;
            },
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
      ],
    );
  }

  Column buildEyeSight(AnalyzePageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.2 ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Thị lực',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Không kính ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm("Mắt trái", "0 ~ 10", model, "leftEye"),
              buildEyeExaminationForm("Mắt phải", "0 ~ 10", model, "rightEye"),
              Text(
                'Có kính',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm(
                  "Mắt trái", "0 ~ 10", model, "leftEyeGlassed"),
              buildEyeExaminationForm(
                  "Mắt phải", "0 ~ 10", model, "rightEyeGlassed"),
            ],
          ),
        ),
      ],
    );
  }

  void changeCheck(String name, bool isCheck) {
    if (isCheck) {
      if (!listCheck.contains(name)) {
        listCheck.add(name);
      }
    } else {
      listCheck.remove(name);
    }
  }
}

Row buildAnthropometricIndex(
    String label, String hintText, AnalyzePageViewModel model, String field) {
  return Row(
    children: [
      SizedBox(width: 15),
      Expanded(
          child: Text(
        label,
        style: TextStyle(fontSize: 18),
      )),
      Expanded(
          child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MainColors.blueBegin.withOpacity(0.6))),
        child: TextField(
          onChanged: (value) {
            model.changeFieldNumber(field, model, value);
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: hintText),
        ),
      )),
    ],
  );
}

Row buildEyeExaminationForm(
    String label, String hintText, AnalyzePageViewModel model, String field) {
  return Row(
    children: [
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      Expanded(
          child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MainColors.blueBegin.withOpacity(0.6))),
        child: TextField(
          onChanged: (value) {
            model.changeFieldNumber(field, model, value);
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: '0 ~ 10'),
        ),
      )),
    ],
  );
}
