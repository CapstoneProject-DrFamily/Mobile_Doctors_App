import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/analyze_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class AnalyzePage extends StatelessWidget {
  List<String> listCheck = List();

  final TimeLineViewModel timelineModel;

  final String transactionId;
  AnalyzePage({@required this.timelineModel, @required this.transactionId});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext contextA) {
    return BaseView<AnalyzePageViewModel>(builder: (contextB, child, model) {
      return FutureBuilder(
        future: model.fetchData(transactionId, timelineModel, listCheck),
        builder: (contextC, snapshop) {
          if (!model.init) {
            return Container(
                width: MediaQuery.of(contextB).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop),
                      image: AssetImage('assets/images/diagnose.jpg'),
                    )),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(contextA).requestFocus(new FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
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
                                width: MediaQuery.of(contextB).size.width,
                                height:
                                    MediaQuery.of(contextB).size.height * 0.65,
                                child: Padding(
                                  padding: !model.keyboard
                                      ? EdgeInsets.only(top: 85.0)
                                      : EdgeInsets.only(top: 10),
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        child:
                                            buildAnalyzeForm(contextB, model),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !model.keyboard ? true : false,
                                // visible: false,
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
                                visible: !model.keyboard ? true : false,
                                child: Positioned(
                                    bottom: 10,
                                    child: Container(
                                      width:
                                          MediaQuery.of(contextB).size.width *
                                              0.6,
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
                                              // timelineModel.changeIndex(1);
                                              if (_formKey.currentState
                                                  .validate()) {
                                                bool isSuccess = await model
                                                    .createExaminationForm(
                                                        transactionId,
                                                        timelineModel);
                                                if (isSuccess) {
                                                  timelineModel.changeIndex(1);
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Error. Please try again",
                                                    textColor: Colors.red,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    backgroundColor:
                                                        Colors.white,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                  );
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Error. Please check your field again",
                                                  textColor: Colors.red,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  gravity: ToastGravity.CENTER,
                                                );
                                              }
                                            },
                                            child: !model.isLoading
                                                ? Text(
                                                    'Next',
                                                    // style: TextStyle(fontSize: 20),
                                                  )
                                                : Container(
                                                    child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ))),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          } else
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        },
      );
    });
  }

  Column buildAnalyzeForm(BuildContext context, AnalyzePageViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Medical History',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: buildMedicalHistory(context, model),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
        // buildMedicalHistory(context, model),
        SizedBox(
          height: 10,
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Clinical Diagnosis',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: buildExamination(model),
              ),
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),

        SizedBox(
          height: 10,
        ),

        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Organ Diagnose',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: buildOrgasm(context, model),
              ),
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),

        SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Container buildOrgasm(BuildContext context, AnalyzePageViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    '2.3.2 ',
                    style: TextStyle(
                        color: Color(0xff0d47a1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      'Organ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff0d47a1),
                          fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff0d47a1)),
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
                            child: TextFormField(
                              initialValue: model.getTextData(index),
                              onChanged: (value) {
                                model.changeFieldText(index, model, value);
                              },
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
      ),
    );
  }

  Container buildMedicalHistory(
      BuildContext context, AnalyzePageViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    initialValue: model.examinationForm.history,
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
                '2. Clinical Diagnosis',
                style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2.1 ',
                    style: TextStyle(
                        color: Color(0xff0d47a1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      'Vital Signs',
                      style: TextStyle(
                        color: Color(0xff0d47a1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildAnthropometricIndex("Pulse", "...", model, "pulseRate"),
            // buildErrorMessage(),
            buildAnthropometricIndex(
                "Temperature", "Celsius", model, "temperature"),
            buildAnthropometricIndex(
                "Blood Pressure", "...", model, "bloodPressure"),
            buildAnthropometricIndex(
                "Respiratory Rate", "...", model, "respiratoryRate"),
            buildAnthropometricIndex("Weight", "kg", model, "weight"),
            buildAnthropometricIndex("Height", "cm", model, "height"),
            buildAnthropometricIndex("BMI", "...", model, "BMI"),
            buildAnthropometricIndex(
                "Hips", "...", model, "waistCircumference"),
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
      ],
    );
  }

  Padding buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Center(
              child: Text(
            'Number should between 0 ~ 999',
            style: TextStyle(color: Colors.red),
          )),
        ],
      ),
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
                style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Paraclinical',
                  style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff0d47a1),
                    fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Full body',
                  style: TextStyle(
                      color: Color(0xff0d47a1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Mucosocutaneous',
            style: TextStyle(fontSize: 16, color: Color(0xff0d47a1)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: model.examinationForm.mucosa,
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
            'Other',
            style: TextStyle(fontSize: 16, color: Color(0xff0d47a1)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: model.examinationForm.otherBody,
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

  Row buildAnthropometricIndex(
      String label, String hintText, AnalyzePageViewModel model, String field) {
    return Row(
      children: [
        SizedBox(width: 15),
        Expanded(
            child: Text(
          label,
          style: TextStyle(fontSize: 16, color: Color(0xff0d47a1)),
        )),
        Expanded(
          //   child: Container(
          // margin: EdgeInsets.only(right: 10, bottom: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: MainColors.blueBegin.withOpacity(0.6))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: TextFormField(
                validator: (value) {
                  if (value.isNotEmpty) {
                    try {
                      double num = double.parse(value);
                      if (num < 0 || num > 999) {
                        return "Range 0 ~ 999";
                      }
                    } catch (e) {
                      return "Must be a number";
                    }
                  }

                  return null;
                },
                initialValue: model.getFieldNumber(field) != null
                    ? model.getFieldNumber(field).toString()
                    : null,
                onChanged: (value) {
                  model.changeFieldNumber(field, model, value);
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: MainColors.blueBegin, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: hintText,
                ),
              ),
            ),
          ),
          // )
        ),
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
              color: Color(0xff0d47a1),
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            child: TextFormField(
              validator: (value) {
                if (value.isNotEmpty) {
                  try {
                    double num = double.parse(value);
                    if (num < 0 || num > 10) {
                      return "Range 0 ~ 10";
                    }
                  } catch (e) {
                    return "Must be a number";
                  }
                }

                return null;
              },
              initialValue: model.getFieldNumber(field) != null
                  ? model.getFieldNumber(field).toString()
                  : null,
              onChanged: (value) {
                model.changeFieldNumber(field, model, value);
              },
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: MainColors.blueBegin, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: hintText,
              ),
            ),
          ),
        )),
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
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff0d47a1),
                    fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Eye Sight',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0d47a1),
                    fontSize: 16,
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
                'No glasses',
                style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm("Left Eye", "0 ~ 10", model, "leftEye"),
              buildEyeExaminationForm("Right Eye", "0 ~ 10", model, "rightEye"),
              Text(
                'With glasses',
                style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm(
                  "Left Eye", "0 ~ 10", model, "leftEyeGlassed"),
              buildEyeExaminationForm(
                  "Right Eye", "0 ~ 10", model, "rightEyeGlassed"),
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
