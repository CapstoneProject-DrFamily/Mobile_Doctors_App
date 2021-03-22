import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../global_variable.dart';

class SchedulePageViewModel extends BaseModel {
  bool isLoading = true;
  bool isFirst = true;
  bool isNotHave = false;

  String dateTime;

  Map<DateTime, List> _events = {};
  Map<DateTime, List> get events => _events;
  List _selectedEvents;
  List get selectedEvents => _selectedEvents;

  final _selectedDay = serverFormater.parse(DateTime.now().toString());
  TimeOfDay selectedTime = TimeOfDay.now();

  CalendarController _calendarController;
  CalendarController get calendarController => _calendarController;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  Future<void> initScheduleToday() async {
    if (isFirst) {
      print('datetime $_selectedDay');
      var current_mon = _selectedDay.month;

      dateTime = _selectedDay.day.toString() +
          " " +
          months[current_mon - 1].toString() +
          " " +
          _selectedDay.year.toString();

      ScheduleModel scheduleModel1 = ScheduleModel(
          dateSchedule: DateTime.now(),
          location: "2549",
          note: "nothing",
          patientId: 15,
          status: true,
          transactionId: "SA");
      ScheduleModel scheduleModel2 = ScheduleModel(
          dateSchedule: DateTime.now(),
          location: "2548",
          note: "nothing",
          patientId: 14,
          status: true,
          transactionId: "SE");
      ScheduleModel scheduleModel3 = ScheduleModel(
          dateSchedule: DateTime.now().subtract(Duration(days: 1)),
          location: "25487",
          note: "nothing",
          patientId: 13,
          status: true,
          transactionId: "SC");
      ScheduleModel scheduleModel4 = ScheduleModel(
          dateSchedule: DateTime.now().subtract(Duration(days: 1)),
          location: "254878",
          note: "nothing",
          patientId: 13,
          status: true,
          transactionId: "SC");
      ScheduleModel scheduleModel5 = ScheduleModel(
          dateSchedule: DateTime.now().subtract(Duration(days: 1)),
          location: "254879",
          note: "nothing",
          patientId: 13,
          status: true,
          transactionId: "SC");
      ScheduleModel scheduleModel6 = ScheduleModel(
          dateSchedule: DateTime.now().subtract(Duration(days: 2)),
          location: "2548790",
          note: "nothing",
          patientId: 13,
          status: true,
          transactionId: "SC");
      ScheduleModel scheduleModel7 = ScheduleModel(
          dateSchedule: DateTime.now().subtract(Duration(days: 2)),
          location: "2548790",
          note: "nothing",
          patientId: 13,
          status: false,
          transactionId: "SC");

      List<ScheduleModel> listSchedule = [];
      listSchedule.add(scheduleModel1);
      listSchedule.add(scheduleModel2);
      listSchedule.add(scheduleModel3);
      listSchedule.add(scheduleModel4);
      listSchedule.add(scheduleModel5);
      listSchedule.add(scheduleModel6);
      listSchedule.add(scheduleModel7);

      List<ScheduleModel> listTemp = [];
      DateTime different;
      for (var item in listSchedule) {
        if (!events
            .containsKey(serverFormater.parse(item.dateSchedule.toString()))) {
          if (listTemp.isNotEmpty) {
            events.update(different, (value) => listTemp);
          }
          listTemp = [];

          events.putIfAbsent(serverFormater.parse(item.dateSchedule.toString()),
              () => listTemp);
          different = serverFormater.parse(item.dateSchedule.toString());
          listTemp.add(item);
        } else {
          listTemp.add(item);
        }
      }

      print(events);

      _calendarController = CalendarController();
      isNotHave = false;
      //init

      isLoading = false;
      isFirst = false;
      notifyListeners();
    }
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');

    var current_mon = day.month;

    dateTime = day.day.toString() +
        " " +
        months[current_mon - 1].toString() +
        " " +
        day.year.toString();

    _selectedEvents = events;
    notifyListeners();
  }

  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    print('dateFirst $first $last');
    notifyListeners();
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
    print('datetTime $first');
    print('datetTime $last');

    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    selectedTime = TimeOfDay.now();

    final TimeOfDay picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );

    if (picked_s != null && picked_s != selectedTime) selectedTime = picked_s;
  }

  Future<void> confirmDateTime() async {
    String dateChoose =
        '${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day} ${selectedTime.hour}:${selectedTime.minute}:00';
    DateTime chooseDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateChoose);

    DateTime validTime = DateTime.now();
    bool isValid = chooseDate.isBefore(validTime);
    if (!isValid) print('choose date $chooseDate valid: $isValid');
  }
}
