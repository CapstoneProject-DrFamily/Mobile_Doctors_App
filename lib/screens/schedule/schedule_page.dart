import 'package:badges/badges.dart';
import 'package:commons/commons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/global_variable.dart';
import 'package:mobile_doctors_apps/screens/history/medical_record_patient_page.dart';
import 'package:mobile_doctors_apps/screens/schedule/add_time.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/health_record_page.dart';
import 'package:mobile_doctors_apps/screens/share/popup_info_patient_page.dart';
import 'package:mobile_doctors_apps/screens/view_model/schedule_page_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SchedulePageViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initScheduleToday(),
          builder: (context, snapshot) {
            if (!model.isFirst) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Scaffold(
                  backgroundColor: Color(0xff0d47a1),
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Your Schedule",
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    actions: <Widget>[
                      InkWell(
                        onTap: () {
                          model.loadBackSchedule();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Center(
                            child: Icon(
                              EvaIcons.refreshOutline,
                              color: Colors.white,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      TableCalendar(
                        events: model.events,
                        calendarController: model.calendarController,
                        initialCalendarFormat: CalendarFormat.week,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        formatAnimation: FormatAnimation.slide,
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: false,
                          formatButtonVisible: true,
                          titleTextStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 15,
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonDecoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          formatButtonShowsNext: true,
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          weekdayStyle: TextStyle(color: Colors.white),
                          weekendStyle: TextStyle(
                            color: Colors.red,
                          ),
                          eventDayStyle: TextStyle(color: Colors.white),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.white),
                          weekendStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        builders: CalendarBuilders(
                          markersBuilder: (context, date, events, holidays) {
                            final children = <Widget>[];

                            if (events.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child:
                                      _buildEventsMarker(model, date, events),
                                ),
                              );
                            }

                            return children;
                          },
                        ),
                        onDaySelected: model.onDaySelected,
                        onVisibleDaysChanged: model.onVisibleDaysChanged,
                        onCalendarCreated: model.onCalendarCreated,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model.dateTime,
                                      style: TextStyle(
                                          color: Color(0xff0d47a1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Expanded(child: Container()),
                                    (model.isAdd)
                                        ? ClipOval(
                                            child: Material(
                                              color:
                                                  Colors.white, // button color
                                              child: InkWell(
                                                splashColor: Colors
                                                    .grey, // inkwell color
                                                child: SizedBox(
                                                  width: 35,
                                                  height: 35,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  AddTimeDialog()
                                                      .showCustomDialog(
                                                          context,
                                                          model.changeDate,
                                                          model.selectedEvents,
                                                          model);
                                                  // await model
                                                  //     .selectTime(context);
                                                  // await model
                                                  //     .confirmDateTime(context);
                                                },
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                (model.loadingListTransaction)
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      )
                                    : (model.selectedEvents == null ||
                                            model.selectedEvents.length == 0)
                                        ? Container(
                                            padding: EdgeInsets.only(top: 120),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/prescription.svg',
                                                  width: 80,
                                                  height: 80,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Don't have any schedule",
                                                  style:
                                                      GoogleFonts.varelaRound(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff0d47a1),
                                                          fontStyle:
                                                              FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                model.selectedEvents.length,
                                            itemBuilder: (context, index) {
                                              return (model
                                                          .selectedEvents[index]
                                                          .transactionScheduleModel !=
                                                      null)
                                                  ? (() {
                                                      // print('status ' +
                                                      //     model
                                                      //         .selectedEvents[
                                                      //             index]
                                                      //         .transactionScheduleModel
                                                      //         .transactionStatus
                                                      //         .toString());
                                                      return _buildDayTask(
                                                        context,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .appointmentTime,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .patientName,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .relationship,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .serviceName,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .location,
                                                        NumberFormat.currency(
                                                                locale: 'vi')
                                                            .format(model
                                                                .selectedEvents[
                                                                    index]
                                                                .transactionScheduleModel
                                                                .servicePrice),
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .patientId,
                                                        model,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .scheduleId,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .note,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .transactionId,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .transactionStatus,
                                                        model
                                                            .selectedEvents[
                                                                index]
                                                            .transactionScheduleModel
                                                            .isOldPatient,
                                                      );
                                                    }())
                                                  : _buildDayNoTask(
                                                      context,
                                                      DateFormat('hh:mm a')
                                                          .format(
                                                        DateTime.parse(model
                                                            .selectedEvents[
                                                                index]
                                                            .appointmentTime),
                                                      ),
                                                      model,
                                                      model
                                                          .selectedEvents[index]
                                                          .scheduleId,
                                                    );
                                            },
                                          )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }

  Padding _buildDayTask(
      BuildContext context,
      String time,
      String name,
      String relation,
      String serviceName,
      String location,
      String servicePrice,
      int patientId,
      SchedulePageViewModel model,
      int scheduleId,
      String note,
      String transactionId,
      int transactionStatus,
      bool isOldPatient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: (!model.isDelete)
            ? []
            : [
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () async {
                    //Delete transaction
                    await _confirmCancelBookingDialog(
                        context,
                        model,
                        scheduleId,
                        time,
                        location,
                        note,
                        patientId,
                        transactionId,
                        true);
                  },
                ),
              ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                DateFormat('hh:mm a').format(DateTime.parse(time)),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                color: Colors.blue[100].withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff0d47a1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (isOldPatient) ? 'OLD PATIENT' : "NEW PATIENT",
                      style: TextStyle(
                          color:
                              (isOldPatient) ? Colors.grey[700] : Colors.green,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            (note != null) ? note : "Nothing",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff0d47a1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        (transactionStatus == 2)
                            ? Container(
                                child: Text(
                                  "Checking",
                                  style: TextStyle(
                                      color: Colors.yellow[800],
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            : (transactionStatus == 3)
                                ? Container(
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : (timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)
                                                .add(Duration(minutes: 30))) &&
                                        timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isAfter(DateTime.parse(time)
                                                .subtract(
                                                    Duration(minutes: 30))))
                                    ? Container(
                                        child: Text(
                                          "On-time",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : (timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)))
                                        ? Container(
                                            child: Text(
                                              "Not yet time",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        : Container(
                                            child: Text("Overtime",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.pin,
                          color: Color(0xff0d47a1),
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            location.split(';')[1].split(':')[1],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (timeCheckFormater.parse(DateTime.now().toString()).isAfter(
                            DateTime.parse(time).add(Duration(minutes: 30))))
                        ? Container(
                            child: ClipOval(
                              child: Material(
                                color: Color(0xff0d47a1), // button color
                                child: InkWell(
                                  splashColor: Colors.grey, // inkwell color
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      EvaIcons.phone,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    model.callPhone(patientId, time);
                                  },
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: Color(0xff0d47a1), // button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        EvaIcons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      model.callPhone(patientId, time);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipOval(
                                child: Material(
                                  color: Color(0xff0d47a1), // button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        EvaIcons.activity,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HealthRecordScreen(
                                            patientId: patientId,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipOval(
                                child: Material(
                                  color: Color(0xff0d47a1), // button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        Icons.assignment_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MedicalCarePatientHistory(
                                            patientId: patientId,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ClipOval(
                                child: Material(
                                  color: Color(0xff0d47a1), // button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // inkwell color
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        EvaIcons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      PatientDialog()
                                          .showCustomDialog(context, patientId);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        servicePrice.toString(),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (transactionStatus == 2)
                            ? Container()
                            : (transactionStatus == 3)
                                ? Container()
                                : (timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)
                                                .add(Duration(minutes: 30))) &&
                                        timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isAfter(DateTime.parse(time)
                                                .subtract(
                                                    Duration(minutes: 30))))
                                    ? RaisedButton(
                                        child: Icon(Icons.timer),
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () async {
                                          // time arrived

                                          await model.arrivedTime(
                                              context,
                                              patientId,
                                              location,
                                              note,
                                              transactionId,
                                              scheduleId,
                                              time);
                                        },
                                      )
                                    : (timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)))
                                        ? RaisedButton(
                                            child: Icon(Icons.timer),
                                            color: Colors.grey,
                                            textColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            onPressed: () {})
                                        : Container(),
                        SizedBox(
                          width: 10,
                        ),
                        (transactionStatus == 2)
                            ? Container()
                            : (transactionStatus == 3)
                                ? Container()
                                : (timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)) ||
                                        timeCheckFormater
                                            .parse(DateTime.now().toString())
                                            .isBefore(DateTime.parse(time)
                                                .add(Duration(minutes: 30))))
                                    ? RaisedButton(
                                        child: Icon(Icons.block),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () async {
                                          await _confirmCancelBookingDialog(
                                              context,
                                              model,
                                              scheduleId,
                                              time,
                                              location,
                                              note,
                                              patientId,
                                              transactionId,
                                              false);
                                        },
                                      )
                                    : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildDayNoTask(BuildContext context, String time,
      SchedulePageViewModel model, int scheduleId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: (!model.isDelete)
            ? []
            : [
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    model.deleteScheduleNoTask(scheduleId, context);
                  },
                )
              ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                time,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Container(
                // margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                color: Colors.blue[100].withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No one have booked yet",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Color(0xff0d47a1),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(
      SchedulePageViewModel model, DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: model.calendarController.isSelected(date)
            ? Colors.brown[500]
            : model.calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  Future _confirmCancelBookingDialog(
      BuildContext context,
      SchedulePageViewModel model,
      scheduleId,
      time,
      location,
      note,
      patientId,
      transactionId,
      bool isDelete) {
    return showDialog(
      context: context,
      builder: (bookingContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            height: 345,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.info,
                  color: Color(0xff4ee1c7),
                  size: 90,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Confirmation?",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                    color: Color(0xff0d47a1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Are you sure want to Cancel this?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'avenir',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () async {
                        Navigator.pop(bookingContext);
                        (!isDelete)
                            ? await model.cancelBooking(context, scheduleId,
                                time, location, note, patientId, transactionId)
                            : model.deleteTaskSchedule(scheduleId, context,
                                location, note, patientId, transactionId);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.pop(bookingContext);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(bookingContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
