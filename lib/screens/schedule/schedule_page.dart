import 'package:commons/commons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
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
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                          titleTextStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 15,
                          ),
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
                                                  await model
                                                      .selectTime(context);
                                                  await model.confirmDateTime();
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
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: model.selectedEvents.length,
                                        itemBuilder: (context, index) {
                                          return (model
                                                  .selectedEvents[index].status)
                                              ? (() {
                                                  int indexTransaction = model
                                                      .listBookingTransaction
                                                      .indexWhere((element) =>
                                                          element.dateStart ==
                                                          model
                                                              .selectedEvents[
                                                                  index]
                                                              .updDatetime);
                                                  print(
                                                      'indexTransaction ${model.listBookingTransaction[indexTransaction].patientId}');

                                                  return _buildDayTask(
                                                    context,
                                                    DateFormat('hh:mm a')
                                                        .format(
                                                      DateTime.parse(model
                                                          .selectedEvents[index]
                                                          .appointmentTime),
                                                    ),
                                                    model
                                                        .listBookingTransaction[
                                                            indexTransaction]
                                                        .patientName,
                                                    model
                                                        .listBookingTransaction[
                                                            indexTransaction]
                                                        .relationShip,
                                                    model
                                                        .listBookingTransaction[
                                                            indexTransaction]
                                                        .serviceName,
                                                    model
                                                        .listBookingTransaction[
                                                            indexTransaction]
                                                        .location
                                                        .split(';')[1]
                                                        .split(':')[1],
                                                    NumberFormat.currency(
                                                            locale: 'vi')
                                                        .format(model
                                                            .listBookingTransaction[
                                                                indexTransaction]
                                                            .servicePrice),
                                                    model
                                                        .listBookingTransaction[
                                                            indexTransaction]
                                                        .patientId,
                                                    model,
                                                  );
                                                }())
                                              : _buildDayNoTask(
                                                  context,
                                                  DateFormat('hh:mm a').format(
                                                    DateTime.parse(model
                                                        .selectedEvents[index]
                                                        .appointmentTime),
                                                  ),
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

  Row _buildDayTask(
      BuildContext context,
      String time,
      String name,
      String relation,
      String serviceName,
      String location,
      String servicePrice,
      int patientId,
      SchedulePageViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            time,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            color: Colors.blue[100].withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name ($relation)',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff0d47a1),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  serviceName,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w500),
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
                        location,
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
                Row(
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
                            model.callPhone(patientId);
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
                          onTap: () {},
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
                              EvaIcons.clock,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _buildDayNoTask(BuildContext context, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            time,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
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
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
