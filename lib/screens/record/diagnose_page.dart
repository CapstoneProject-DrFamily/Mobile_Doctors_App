import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:mobile_doctors_apps/enums/ProcessTimeline.dart';
import 'package:mobile_doctors_apps/helper/StatefulWrapper.dart';
import 'package:mobile_doctors_apps/helper/common.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/diagnose_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';
import 'package:timelines/timelines.dart';

class DiagnosePage extends StatelessWidget {
  List<String> listCheck = List();
  bool keyboardOn = false;
  int _processIndex = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<DiagnosePageViewModel>(
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
              appBar: AppBar(),
              // resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: timelineProcess(context),
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
                                  color: MainColors.blueBegin.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              width: size.width,
                              height: size.height * 0.6,
                              child: SingleChildScrollView(
                                child: Column(
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 10,
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '2.3.2 ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                  children: List.generate(
                                                      model.listSpeciality
                                                          .length, (index) {
                                                    return Column(
                                                      children: [
                                                        Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Container(
                                                              child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Flexible(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          model
                                                                              .listSpeciality[index]
                                                                              .name,
                                                                          style:
                                                                              TextStyle(fontSize: 18),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Checkbox(
                                                                  value: listCheck.contains(model
                                                                          .listSpeciality[
                                                                              index]
                                                                          .name)
                                                                      ? true
                                                                      : false,
                                                                  onChanged:
                                                                      (value) {
                                                                    print(
                                                                        value);

                                                                    model.changeCheck(
                                                                        model
                                                                            .listSpeciality[index]
                                                                            .name,
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
                                                              .contains(model
                                                                  .listSpeciality[
                                                                      index]
                                                                  .name),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  maxLines: 3,
                                                                  decoration: InputDecoration(
                                                                      hintText:
                                                                          'Enter text',
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
                                        'assets/images/time_line_3.png',
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
        );
      },
    );
  }

  Container timelineProcess(BuildContext context) {
    return Container(
      height: 150,
      child: Timeline.tileBuilder(
          theme: TimelineThemeData(
              direction: Axis.horizontal,
              connectorTheme: ConnectorThemeData(space: 30, thickness: 5)),
          builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemExtentBuilder: (_, __) =>
                  MediaQuery.of(context).size.width /
                  ProcessTimeline.values.length,
              oppositeContentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Image.asset(
                    'assets/images/time_line_${index + 1}.png',
                    width: 200,
                  ),
                );
              },
              contentsBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    ProcessTimeline.values[index].toString().split(".").last,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Common.getColor(index, _processIndex),
                    ),
                  ),
                );
              },
              indicatorBuilder: (_, index) {
                var color;
                var child;
                if (index == _processIndex) {
                  color = Common.inProgressColor;
                  child = Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                      )

                      //     CircularProgressIndicator(
                      //   strokeWidth: 3.0,
                      //   valueColor: AlwaysStoppedAnimation(Colors.white),
                      // ),
                      );
                } else if (index < _processIndex) {
                  color = Common.completeColor;
                  child = Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 25.0,
                  );
                } else {
                  color = Common.todoColor;
                }

                if (index <= _processIndex) {
                  return Stack(
                    children: [
                      CustomPaint(
                        size: Size(30.0, 30.0),
                        painter: _BezierPainter(
                          color: color,
                          drawStart: index > 0,
                          drawEnd: index < _processIndex,
                        ),
                      ),
                      DotIndicator(
                        size: 30.0,
                        color: color,
                        child: child,
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      CustomPaint(
                        size: Size(15.0, 15.0),
                        painter: _BezierPainter(
                          color: color,
                          drawEnd: index < ProcessTimeline.values.length - 1,
                        ),
                      ),
                      OutlinedDotIndicator(
                        borderWidth: 4.0,
                        color: color,
                      ),
                    ],
                  );
                }
              },
              connectorBuilder: (_, index, type) {
                if (index > 0) {
                  if (index == _processIndex) {
                    final prevColor = Common.getColor(index - 1, _processIndex);
                    final color = Common.getColor(index, _processIndex);
                    var gradientColors;
                    if (type == ConnectorType.start) {
                      gradientColors = [
                        Color.lerp(prevColor, color, 0.5),
                        color
                      ];
                    } else {
                      gradientColors = [
                        prevColor,
                        Color.lerp(prevColor, color, 0.5)
                      ];
                    }
                    return DecoratedLineConnector(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                        ),
                      ),
                    );
                  } else {
                    return SolidLineConnector(
                      color: Common.getColor(index, _processIndex),
                    );
                  }
                } else {
                  return null;
                }
              },
              itemCount: ProcessTimeline.values.length)),
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

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    @required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}
