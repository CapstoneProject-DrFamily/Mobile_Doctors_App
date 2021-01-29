import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:mobile_doctors_apps/helper/StatefulWrapper.dart';

import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/analyze_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class AnalyzePage extends StatelessWidget {
  List<String> listCheck = List();
  bool keyboardOn = false;
  int _processIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                width: size.width,
                                height: size.height * 0.6,
                                child: SingleChildScrollView(
                                  child: buildAnalyzeForm(size, model),
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
        SizedBox(
          height: 100,
        ),
        MedicalHistory(size: size),
        SizedBox(
          height: 10,
        ),
        Container(
          width: size.width * 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Examination(),
                Divider(
                  thickness: 0.5,
                  color: MainColors.blueBegin,
                ),
                EyeSightPart(),
                Divider(
                  thickness: 0.5,
                  color: MainColors.blueBegin,
                ),
                FullBody(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          Text(
                            '2.3.2 ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                      children:
                          List.generate(model.listSpeciality.length, (index) {
                        return Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              model.listSpeciality[index].name,
                                              style: TextStyle(fontSize: 18),
                                            ),
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
                                            listCheck);
                                      },
                                    ),
                                  )
                                ],
                              )),
                            ),
                            Visibility(
                              visible: listCheck
                                  .contains(model.listSpeciality[index].name),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: 'Enter text',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
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
            ),
          ),
        ),
        SizedBox(
          height: 20,
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

class FullBody extends StatelessWidget {
  const FullBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class EyeSightPart extends StatelessWidget {
  const EyeSightPart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mắt trái',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0 ~ 10'),
                  )),
                  Expanded(
                    child: Text(
                      'Mắt phải',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0 ~ 10'),
                  )),
                ],
              ),
              Text(
                'Có kính',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mắt trái',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0 ~ 10'),
                  )),
                  Expanded(
                    child: Text(
                      'Mắt phải',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '0 ~ 10'),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Examination extends StatelessWidget {
  const Examination({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
                child: Text(
              'Mạch',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'nhịp/phút'),
            )),
            Expanded(
                child: Text(
              'Nhiệt độ',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'độ C'),
            ))
          ],
        ),
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
                child: Text(
              'Huyết áp',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '...'),
            )),
            Expanded(
                child: Text(
              'Nhịp thở',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '...'),
            ))
          ],
        ),
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
                child: Text(
              'Cân nặng',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'kg'),
            )),
            Expanded(
                child: Text(
              'Chiều cao',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'cm'),
            ))
          ],
        ),
        Row(
          children: [
            SizedBox(width: 15),
            Expanded(
                child: Text(
              'BMI',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '...'),
            )),
            Expanded(
                child: Text(
              'Vòng bụng',
              style: TextStyle(fontSize: 18),
            )),
            Expanded(
                child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: '...'),
            ))
          ],
        ),
      ],
    );
  }
}

class MedicalHistory extends StatelessWidget {
  const MedicalHistory({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
                '1. Bệnh sử',
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
                    decoration:
                        InputDecoration.collapsed(hintText: 'Enter your text'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
