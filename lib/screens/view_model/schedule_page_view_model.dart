import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/model/schedule_add_model.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';
import 'package:mobile_doctors_apps/model/transaction_booking_model.dart';
import 'package:mobile_doctors_apps/repository/patient_repo.dart';
import 'package:mobile_doctors_apps/repository/schedule_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../global_variable.dart';

class SchedulePageViewModel extends BaseModel {
  final IScheduleRepo _scheduleRepo = ScheduleRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IPatientRepo _patientRepo = PatientRepo();

  bool isLoading = true;
  bool isFirst = true;
  bool isNotHave = false;
  bool isAdd = true;
  bool loadingListTransaction = false;

  String dateTime;

  Map<DateTime, List> _events = {};
  Map<DateTime, List> get events => _events;
  List _selectedEvents;
  List get selectedEvents => _selectedEvents;

  List<TransactionBookingModel> _listBookingTransaction;
  List<TransactionBookingModel> get listBookingTransaction =>
      _listBookingTransaction;

  final _selectedDay = serverFormater.parse(DateTime.now().toString());
  TimeOfDay selectedTime = TimeOfDay.now();

  CalendarController _calendarController;
  CalendarController get calendarController => _calendarController;

  DateTime dateStart;
  DateTime dateEnd;

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

  int doctorId;
  String doctorName;
  DateTime _changeDate = DateTime.now();

  Future<void> initScheduleToday() async {
    if (isFirst) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getInt("doctorId");
      doctorName = prefs.getString("usName");
      loadingListTransaction = true;

      print('datetime $_selectedDay');
      var current_mon = _selectedDay.month;

      dateTime = _selectedDay.day.toString() +
          " " +
          months[current_mon - 1].toString() +
          " " +
          _selectedDay.year.toString();

      _calendarController = CalendarController();
      isNotHave = false;
      //init
      isLoading = false;

      isFirst = false;
      notifyListeners();
    }
  }

  Future<void> initSchedule(String dateStart, String dateEnd) async {
    _events = {};

    List<ScheduleModel> listSchedule =
        await _scheduleRepo.loadListSchedule(dateStart, dateEnd, doctorId);
    List<ScheduleModel> listTemp = [];
    DateTime different;
    for (var item in listSchedule) {
      if (!events
          .containsKey(serverFormater.parse(item.appointmentTime.toString()))) {
        if (listTemp.isNotEmpty) {
          events.update(different, (value) => listTemp);
        }
        listTemp = [];

        events.putIfAbsent(
            serverFormater.parse(item.appointmentTime.toString()),
            () => listTemp);
        different = serverFormater.parse(item.appointmentTime.toString());
        listTemp.add(item);
      } else {
        listTemp.add(item);
      }
    }
    print('events $events');
  }

  void onDaySelected(DateTime day, List events, List holidays) async {
    print('CALLBACK: _onDaySelected');
    loadingListTransaction = true;
    notifyListeners();

    isAdd = true;

    _changeDate = day;

    if (day.isBefore(_selectedDay) ||
        serverFormater.parse(day.toString()).isAtSameMomentAs(_selectedDay))
      isAdd = false;

    var currentMon = day.month;

    dateTime = day.day.toString() +
        " " +
        months[currentMon - 1].toString() +
        " " +
        day.year.toString();

    _selectedEvents = events;
    print('selected event $_selectedEvents');

    await getScheduleBooking(
        serverFormater.parse(_changeDate.toString()).toString());
    loadingListTransaction = false;
    notifyListeners();
  }

  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    dateStart = serverFormater.parse(first.toString());
    dateEnd = serverFormater.parse(last.toString());
    print('CALLBACK: _onVisibleDaysChanged');
    print('dateFirst $first $last');
    notifyListeners();
  }

  void onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) async {
    isAdd = false;
    print('CALLBACK: _onCalendarCreated');
    dateStart = serverFormater.parse(first.toString());
    dateEnd = serverFormater.parse(last.toString());

    await initSchedule(serverFormater.parse(first.toString()).toString(),
        serverFormater.parse(last.toString()).toString());
    _selectedEvents = _events[_selectedDay];
    print('selected Event: ${_selectedEvents[0].status}');
    print('datetTime $first');
    print('datetTime $last');
    loadingListTransaction = false;

    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    selectedTime = TimeOfDay.now();

    selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );
  }

  Future<void> confirmDateTime() async {
    if (selectedTime != null) {
      String month, day, hour, minute;
      if (_changeDate.month <= 9)
        month = '0${_changeDate.month}';
      else
        month = _changeDate.month.toString();

      if (_changeDate.day <= 9)
        day = '0${_changeDate.day}';
      else
        day = _changeDate.day.toString();

      if (selectedTime.hour <= 9)
        hour = '0${selectedTime.hour}';
      else
        hour = selectedTime.hour.toString();

      if (selectedTime.minute <= 9)
        minute = '0${selectedTime.minute}';
      else
        minute = selectedTime.minute.toString();

      String dateChooseString =
          '${_changeDate.year}-$month-$day $hour:$minute:00';

      DateTime dateChoose = DateTime.parse(dateChooseString);

      DateTime validTime =
          DateFormat('yyyy-MM-dd hh:mm').parse(DateTime.now().toString());

      if (dateChoose.subtract(Duration(hours: 2)).isBefore(validTime)) {
        Fluttertoast.showToast(
          msg: "Please set Time after 2 hours from the present.",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        //add schedule
        bool status = await addSchedule(dateChoose);
        if (status) {
          loadingListTransaction = true;
          notifyListeners();
          await initSchedule(dateStart.toString(), dateEnd.toString());
          print(
              'event ${events[serverFormater.parse(_changeDate.toString())]}');
          _selectedEvents =
              events[serverFormater.parse(_changeDate.toString())];
          print("oke selectedEvent " + _selectedEvents.toString());
          loadingListTransaction = false;

          notifyListeners();
        } else
          Fluttertoast.showToast(
            msg: "Error please try agian.",
            textColor: Colors.red,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.white,
            gravity: ToastGravity.CENTER,
          );
      }
    }
  }

  Future<bool> addSchedule(DateTime dateChoose) async {
    ScheduleAddModel addScheduleModel = ScheduleAddModel(
        appointmentTime: dateChoose.toString(),
        doctorId: doctorId,
        insBy: doctorName,
        status: false);
    String jsonSchedule = jsonEncode(addScheduleModel.toJson());
    print('jsonSchedule: $jsonSchedule');
    bool status = await _scheduleRepo.createSchedule(jsonSchedule);
    return status;
  }

  Future<void> getScheduleBooking(String dateChoose) async {
    _listBookingTransaction = await _transactionRepo
        .getListTransactionBookingInDay(doctorId, dateChoose);

    // print('list Schedule Length ${_listBookingTransaction.length}');
  }

  Future<void> callPhone(int patientId) async {
    var phone = await _patientRepo.getPatientPhone(patientId);
    print('phone $phone');

    await launch('tel://$phone');
  }
}
