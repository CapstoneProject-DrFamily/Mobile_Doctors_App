import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:loading_button/loading_button.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/patient/patient_detail_page.dart';

import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/home_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';
import 'dart:ui' as ui;

class HomePage extends StatelessWidget {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView<HomePageViewModel>(builder: (context, child, model) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundhome.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LoadingButton(
                      onPressed: () async {
                        if (!model.active) {
                          model.isConnecting(true);
                          model.isFinding(true);
                          bool result = await model.activeDoc();
                          if (result) {
                            print('success');
                            model.isActive(true);
                            model.isConnecting(false);
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Ready to cure",
                                backgroundColor: Colors.lightBlue[200]);
                          } else {
                            print('fail');
                            model.isActive(false);
                            model.isConnecting(false);
                            model.isFinding(false);
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: "Your transaction was successful!",
                                backgroundColor: Colors.lightBlue[200]);
                          }
                        } else {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              text: "Your transaction was successful!",
                              backgroundColor: Colors.lightBlue[200],
                              onConfirmBtnTap: () {
                                model.isConnecting(false);
                                model.isActive(false);
                                model.isFinding(false);
                                Navigator.pop(context);
                              },
                              onCancelBtnTap: () {
                                model.isActive(true);
                                print('Active : ' + model.active.toString());
                                Navigator.pop(context);
                              });
                        }
                      },
                      backgroundColor: Colors.blueAccent[200],
                      isLoading: model.connecting,
                      loadingWidget: SizedBox(
                        width: 25,
                        height: 25,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 20),
                              blurRadius: 80,
                              color: Colors.lightBlue[200])
                        ], borderRadius: BorderRadius.circular(100.0)),
                        child: Text(
                          !model.active ? 'Connect' : 'Disconnect',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, bottom: 20),
                          child: Image(
                              image: model.active
                                  ? AssetImage('assets/ondemand.png')
                                  : AssetImage('assets/offdemand.png'),
                              width: 100),
                          margin: const EdgeInsets.only(left: 20)),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 20),
                        child: model.finding
                            ? PulsatingCircleIconButton(
                                icon: null,
                                onTap: () {},
                              )
                            : Text(''),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: MainColors.blueBegin.withOpacity(0.6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              border: Border.all(
                                                  color: MainColors.blueEnd,
                                                  width: 5),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    MainColors.blueBegin,
                                                    MainColors.blueEnd
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: MainColors.blueBegin,
                                                    blurRadius: 12,
                                                    offset: Offset(0, 6))
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            top: 0,
                                            child: CustomPaint(
                                              size: Size(70, 100),
                                              painter: CustomCardShapePainter(
                                                  24,
                                                  MainColors.blueBegin,
                                                  MainColors.blueEnd),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://gocsuckhoe.com/wp-content/uploads/2020/09/avatar-facebook.jpg',
                                                    ),
                                                    radius: 35,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Nguyễn Thị A',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons.location_on,
                                                              color: MainColors
                                                                  .blueEnd),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5.0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                  '263 Hoàng Hoa Thám, P4, Q5, TP. Hà Nội',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.add_box,
                                                              color: MainColors
                                                                  .blueEnd),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      5.0,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                  'Đau đầu',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: RaisedButton(
                                                              child: Text(
                                                                  'Accept'),
                                                              color:
                                                                  Colors.green,
                                                              textColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                PatientDetailPage()));
                                                              },
                                                            ),
                                                          ),
                                                          RaisedButton(
                                                            child:
                                                                Text('Cancel'),
                                                            color: Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MedicineListPage()));
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(Icons.location_on,
                                                          color: MainColors
                                                              .blueEnd),
                                                      Text('4.8 km',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 10),
                                                      CountdownTimer(
                                                          endTime: endTime,
                                                          widgetBuilder:
                                                              (_, time) {
                                                            if (time == null) {
                                                              return Text(
                                                                'Expired',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              );
                                                            }
                                                            return Text(
                                                                '0:${time.sec}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white));
                                                          })
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PulsatingCircleIconButton extends StatefulWidget {
  const PulsatingCircleIconButton(
      {Key key, @required this.onTap, @required this.icon})
      : super(key: key);

  final GestureTapCallback onTap;
  final Icon icon;

  @override
  _PulsatingCircleIconButton createState() => _PulsatingCircleIconButton();
}

class _PulsatingCircleIconButton extends State<PulsatingCircleIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(begin: 0.0, end: 12.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: widget.onTap,
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, snapshot) {
            return Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    for (int i = 1; i <= 4; i++)
                      BoxShadow(
                          color: Colors.lightBlue[100]
                              .withOpacity(_animationController.value / 2),
                          spreadRadius: _animation.value * i)
                  ]),
              child: widget.icon,
            );
          }),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor) {}

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 15.0;
    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);
    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
