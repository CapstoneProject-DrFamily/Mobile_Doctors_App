import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                                  "Please select Time for your appoinment.",
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
                                          );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
