import 'package:commons/commons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/add_time_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/schedule_page_view_model.dart';

class AddTimeDialog {
  void showCustomDialog(
      BuildContext context,
      DateTime datetime,
      List<dynamic> listHasChoose,
      SchedulePageViewModel schedulePageViewModel) {
    showDialog(
      context: context,
      builder: (addTimeContext) {
        return BaseView<AddTimeViewModel>(
          builder: (context, child, addTimeModel) {
            return FutureBuilder(
              future: addTimeModel.initAddTime(datetime, listHasChoose),
              builder: (context, snapshot) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: (addTimeModel.isLoadingAddTimePopUp)
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          constraints: new BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.7,
                          ),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Choose your Time",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff0d47a1),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please select time for your appoinment.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "These time slots are in Vietnam timezone \n(GMT+7:00).",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff0d47a1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xff0d47a1)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        addTimeModel.listTimeDisplay.length,
                                    itemBuilder: (context, index) {
                                      return (addTimeModel
                                                  .listTimeDisplay.values
                                                  .toList()[index] ==
                                              1)
                                          ? Container()
                                          : InkWell(
                                              onTap: () {
                                                (addTimeModel.listTimeDisplay
                                                            .values
                                                            .toList()[index] ==
                                                        2)
                                                    ? print("notThing")
                                                    : addTimeModel
                                                        .chooseDateTime(
                                                            addTimeModel
                                                                .listTimeDisplay
                                                                .keys
                                                                .toList()[index],
                                                            index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: (index ==
                                                              addTimeModel
                                                                      .listTimeDisplay
                                                                      .length -
                                                                  1)
                                                          ? BorderSide(
                                                              color:
                                                                  Colors.white,
                                                              width: 0.5,
                                                            )
                                                          : BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 0.5,
                                                            ),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        addTimeModel.timeFormat
                                                            .format(addTimeModel
                                                                .listTimeDisplay
                                                                .keys
                                                                .toList()[index]),
                                                        style: TextStyle(
                                                          color: Color(
                                                                  0xff0d47a1)
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                      (addTimeModel.listTimeDisplay
                                                                      .values
                                                                      .toList()[
                                                                  index] ==
                                                              2)
                                                          ? Icon(EvaIcons
                                                              .radioButtonOn)
                                                          : addTimeModel
                                                                  .listTimeChoose
                                                                  .contains(addTimeModel
                                                                          .listTimeDisplay
                                                                          .keys
                                                                          .toList()[
                                                                      index])
                                                              ? Icon(EvaIcons
                                                                  .checkmarkCircle2)
                                                              : Icon(EvaIcons
                                                                  .checkmarkCircle2Outline),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 60,
                                color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 7,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, position) {
                                          return Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: FittedBox(
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          datetime
                                                              .add(Duration(
                                                                  days:
                                                                      position))
                                                              .day
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          )),
                                                      Text(
                                                        DateFormat('EE').format(
                                                            datetime.add(Duration(
                                                                days:
                                                                    position))),
                                                        style: TextStyle(
                                                            fontSize: 5),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(EvaIcons.checkmarkCircle2Outline),
                                      Text(
                                        "Time available",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(EvaIcons.checkmarkCircle2),
                                      Text(
                                        "Time picked",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(EvaIcons.radioButtonOn),
                                  Text(
                                    "Time has schedule",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  schedulePageViewModel.addMultipleSchedule(
                                      addTimeModel.listTimeChoose, context);
                                },
                                child: Container(
                                  width: 130,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff374ABE),
                                          Color(0xff64B6FF)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class AddSchedulePage extends StatelessWidget {
  final BuildContext context;
  final DateTime datetime;
  final List<dynamic> listHasChoose;
  final SchedulePageViewModel schedulePageViewModel;

  AddSchedulePage(
      {@required this.context,
      @required this.datetime,
      @required this.listHasChoose,
      @required this.schedulePageViewModel});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddTimeViewModel>(builder: (context, child, addTimeModel) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Create new schedule",
            textAlign: TextAlign.center,
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xff0d47a1),
            ),
          ),
        ),
        body: FutureBuilder(
          future: addTimeModel.initAddTime(datetime, listHasChoose),
          builder: (context, snapshot) {
            if (addTimeModel.isLoadingAddTimePopUp) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please select time for your appoinment.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "These time slots are in Vietnam timezone \n(GMT+7:00).",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0d47a1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff0d47a1), width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      addTimeModel.listTimeDisplay.length,
                                  itemBuilder: (context, index) {
                                    return (addTimeModel.listTimeDisplay.values
                                                .toList()[index] ==
                                            1)
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              (addTimeModel.listTimeDisplay
                                                          .values
                                                          .toList()[index] ==
                                                      2)
                                                  ? print("notThing")
                                                  : addTimeModel.chooseDateTime(
                                                      addTimeModel
                                                          .listTimeDisplay.keys
                                                          .toList()[index],
                                                      index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: (index ==
                                                            addTimeModel
                                                                    .listTimeDisplay
                                                                    .length -
                                                                1)
                                                        ? BorderSide(
                                                            color: Colors.white,
                                                            width: 0.5,
                                                          )
                                                        : BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.5,
                                                          ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      addTimeModel.timeFormat
                                                          .format(addTimeModel
                                                              .listTimeDisplay
                                                              .keys
                                                              .toList()[index]),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color(0xff0d47a1)
                                                            .withOpacity(0.8),
                                                      ),
                                                    ),
                                                    (addTimeModel.listTimeDisplay
                                                                    .values
                                                                    .toList()[
                                                                index] ==
                                                            2)
                                                        ? Icon(EvaIcons
                                                            .radioButtonOn)
                                                        : addTimeModel
                                                                .listTimeChoose
                                                                .contains(addTimeModel
                                                                        .listTimeDisplay
                                                                        .keys
                                                                        .toList()[
                                                                    index])
                                                            ? Icon(EvaIcons
                                                                .checkmarkCircle2)
                                                            : Icon(EvaIcons
                                                                .checkmarkCircle2Outline),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 7,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, position) {
                                        return Container(
                                            margin: position != 0
                                                ? EdgeInsets.only(left: 10)
                                                : null,
                                            child: GestureDetector(
                                              onTap: () {
                                                addTimeModel.changeSelectedDay(
                                                    datetime.add(Duration(
                                                        days: position)),
                                                    datetime.add(
                                                        Duration(days: 0)));
                                                print(datetime.add(
                                                    Duration(days: position)));
                                              },
                                              child: FittedBox(
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: addTimeModel
                                                            .listDaySelected
                                                            .contains(datetime
                                                                .add(Duration(
                                                                    days:
                                                                        position)))
                                                        ? Color(0xff0d47a1)
                                                        : Colors.blueGrey[100],
                                                    border: Border.all(
                                                        color: addTimeModel
                                                                .listDaySelected
                                                                .contains(datetime
                                                                    .add(Duration(
                                                                        days:
                                                                            position)))
                                                            ? Color(0xff0d47a1)
                                                            : Colors
                                                                .blueGrey[100]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        DateFormat.MMMM().format(
                                                            datetime.add(Duration(
                                                                days:
                                                                    position))),
                                                        style: TextStyle(
                                                          fontSize: 5,
                                                          color: addTimeModel
                                                                  .listDaySelected
                                                                  .contains(datetime
                                                                      .add(Duration(
                                                                          days:
                                                                              position)))
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                          datetime
                                                              .add(Duration(
                                                                  days:
                                                                      position))
                                                              .day
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: addTimeModel
                                                                    .listDaySelected
                                                                    .contains(datetime.add(
                                                                        Duration(
                                                                            days:
                                                                                position)))
                                                                ? Colors.white
                                                                : Colors.black,
                                                          )),
                                                      Text(
                                                        DateFormat('EE').format(
                                                            datetime.add(Duration(
                                                                days:
                                                                    position))),
                                                        style: TextStyle(
                                                          fontSize: 5,
                                                          color: addTimeModel
                                                                  .listDaySelected
                                                                  .contains(datetime
                                                                      .add(Duration(
                                                                          days:
                                                                              position)))
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('Repeat on next 7 days'),
                                      Switch(
                                        value: addTimeModel.isRepeat,
                                        onChanged: (value) {
                                          addTimeModel.changeRepeat(
                                              value, datetime);
                                          print(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                schedulePageViewModel.addMultipleSchedule(
                                    addTimeModel.listTimeChoose, context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff374ABE),
                                        Color(0xff64B6FF)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
