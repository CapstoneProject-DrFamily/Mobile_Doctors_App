import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_doctors_apps/model/schedule_add_model.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/model/transaction_booking_model.dart';
import 'package:mobile_doctors_apps/repository/patient_repo.dart';
import 'package:mobile_doctors_apps/repository/schedule_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
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
  bool isDelete = true;
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

  DatabaseReference _transactionRequest;
  FirebaseUser _firebaseuser;
  String userId;

  Future<void> initScheduleToday() async {
    if (isFirst) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getInt("doctorId");
      doctorName = prefs.getString("usName");
      loadingListTransaction = true;

      _transactionRequest =
          FirebaseDatabase.instance.reference().child("Transaction");
      _firebaseuser = await FirebaseAuth.instance.currentUser();
      userId = _firebaseuser.uid;

      print('datetime $_selectedDay');
      var current_mon = _selectedDay.month;

      dateTime = _selectedDay.day.toString() +
          " " +
          months[current_mon - 1].toString() +
          " " +
          _selectedDay.year.toString();

      _calendarController = CalendarController();

      await getScheduleBooking();
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
    if (listSchedule == null) {
      print("not have");
    } else {
      for (var item in listSchedule) {
        if (!events.containsKey(
            serverFormater.parse(item.appointmentTime.toString()))) {
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
  }

  void onDaySelected(DateTime day, List events, List holidays) async {
    print('CALLBACK: _onDaySelected');
    loadingListTransaction = true;
    notifyListeners();

    isAdd = true;
    isDelete = true;

    _changeDate = day;

    if (day.isBefore(_selectedDay)) isDelete = false;

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

    loadingListTransaction = false;
    notifyListeners();
  }

  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) async {
    dateStart = serverFormater.parse(first.toString());
    dateEnd = serverFormater.parse(last.toString());
    await initSchedule(
        serverFormater.parse(first.toString()).toString(),
        serverFormater
            .parse(last.add(Duration(days: 1)).toString())
            .toString());
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

    await initSchedule(
        serverFormater.parse(first.toString()).toString(),
        serverFormater
            .parse(last.add(Duration(days: 1)).toString())
            .toString());
    if (events.isEmpty) {
      print("event null");
    } else {
      _selectedEvents = _events[_selectedDay];
      print('datetTime $first');
      print('datetTime $last');
    }

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

  Future<void> confirmDateTime(BuildContext context) async {
    if (selectedTime != null) {
      waitDialog(context, message: "Setting your Schedule please wait...");

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

      print('dateChoose $dateChoose');

      if (dateChoose.hour >= 21 || dateChoose.hour < 8) {
        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: "Time set much be > 8 AM and < 21 PM.",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        bool isValid = validateDateTime(dateChoose);

        if (!isValid) {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Please set Time before or after the exist time 1:30 hours.",
            textColor: Colors.red,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.white,
            gravity: ToastGravity.CENTER,
          );
        } else {
          //add schedule
          bool status = await addSchedule(dateChoose);
          if (status) {
            Navigator.pop(context);

            loadBackSchedule();
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

  Future<void> getScheduleBooking() async {
    _listBookingTransaction =
        await _transactionRepo.getListTransactionBookingInDay(doctorId);

    // print('list Schedule Length ${_listBookingTransaction.length}');
  }

  Future<void> callPhone(int patientId, String time) async {
    var phone = await _patientRepo.getPatientPhone(patientId);
    print('phone $phone');

    await launch('tel://$phone');
  }

  bool validateDateTime(DateTime datechoose) {
    bool isValid = false;
    if (_selectedEvents.length == 0) {
      isValid = true;
      return isValid;
    } else if (_selectedEvents.length == 1) {
      if (DateTime.parse(_selectedEvents[0].appointmentTime)
          .isBefore(datechoose)) {
        if (DateTime.parse(_selectedEvents[0].appointmentTime)
                .add(Duration(hours: 1, minutes: 30))
                .isBefore(datechoose) ||
            DateTime.parse(_selectedEvents[0].appointmentTime)
                .add(Duration(hours: 1, minutes: 30))
                .isAtSameMomentAs(datechoose)) {
          isValid = true;
          return isValid;
        } else
          return isValid;
      } else {
        if (DateTime.parse(_selectedEvents[0].appointmentTime)
                .subtract(Duration(hours: 1, minutes: 30))
                .isAfter(datechoose) ||
            DateTime.parse(_selectedEvents[0].appointmentTime)
                .subtract(Duration(hours: 1, minutes: 30))
                .isAtSameMomentAs(datechoose)) {
          isValid = true;
          return isValid;
        } else {
          return isValid;
        }
      }
    } else {
      var startList = DateTime.parse(_selectedEvents[0].appointmentTime);
      var endList = DateTime.parse(
          _selectedEvents[_selectedEvents.length - 1].appointmentTime);

      print('endList $endList');
      if (startList.isAfter(datechoose)) {
        if (DateTime.parse(_selectedEvents[0].appointmentTime)
                .subtract(Duration(hours: 1, minutes: 30))
                .isAfter(datechoose) ||
            DateTime.parse(_selectedEvents[0].appointmentTime)
                .subtract(Duration(hours: 1, minutes: 30))
                .isAtSameMomentAs(datechoose)) {
          isValid = true;
          return isValid;
        }
      }

      if (endList.isBefore(datechoose)) {
        if (DateTime.parse(
                    _selectedEvents[_selectedEvents.length - 1].appointmentTime)
                .add(Duration(hours: 1, minutes: 30))
                .isBefore(datechoose) ||
            DateTime.parse(
                    _selectedEvents[_selectedEvents.length - 1].appointmentTime)
                .add(Duration(hours: 1, minutes: 30))
                .isAtSameMomentAs(datechoose)) {
          isValid = true;
          return isValid;
        }
      }

      for (int i = 0; i < _selectedEvents.length; i++) {
        print("in for");
        var start = DateTime.parse(_selectedEvents[i].appointmentTime);
        if ((i + 1) != _selectedEvents.length) {
          var end = DateTime.parse(_selectedEvents[i + 1].appointmentTime);

          if ((start
                      .add(Duration(hours: 1, minutes: 30))
                      .isBefore(datechoose) ||
                  start
                      .add(Duration(hours: 1, minutes: 30))
                      .isAtSameMomentAs(datechoose)) &&
              (end
                      .subtract(Duration(hours: 1, minutes: 30))
                      .isAfter(datechoose) ||
                  end
                      .subtract(Duration(hours: 1, minutes: 30))
                      .isAtSameMomentAs(datechoose))) {
            isValid = true;
            return isValid;
          }
        }
      }
    }

    return isValid;
  }

  Future<void> deleteScheduleNoTask(
      int scheduleId, BuildContext context) async {
    waitDialog(context, message: "Deleting your booking please wait...");

    bool isDelete = await _scheduleRepo.deleteScheduleNoTask(scheduleId);
    if (isDelete) {
      Navigator.pop(context);
      loadBackSchedule();
    }
  }

  void loadBackSchedule() async {
    loadingListTransaction = true;
    notifyListeners();
    await initSchedule(
        dateStart.toString(), dateEnd.add(Duration(days: 1)).toString());

    print('event ${events[serverFormater.parse(_changeDate.toString())]}');
    _selectedEvents = events[serverFormater.parse(_changeDate.toString())];
    print("oke selectedEvent " + _selectedEvents.toString());
    loadingListTransaction = false;
    notifyListeners();
  }

  void deleteTaskSchedule(
    int scheduleId,
    BuildContext context,
    String location,
    String note,
    int patientId,
    String transactionID,
  ) async {
    waitDialog(context, message: "Deleting your booking please wait...");

    bool isDelete = await _scheduleRepo.deleteScheduleNoTask(scheduleId);
    if (isDelete) {
      Transaction transactionTemp = new Transaction(
          doctorId: doctorId,
          location: location,
          note: note,
          patientId: patientId,
          status: 4,
          transactionId: transactionID,
          estimatedTime: null);
      bool isUpdate = await _transactionRepo.updateTransaction(transactionTemp);
      if (isUpdate) {
        Navigator.pop(context);
        loadBackSchedule();
      }
    }
  }

  Future<void> cancelBooking(
      BuildContext context,
      int scheduleId,
      String appointmentTime,
      String location,
      String note,
      int patientId,
      String transactionID) async {
    waitDialog(context, message: "Canceling booking please wait...");

    String updateScheduleJson = jsonEncode({
      "scheduleId": scheduleId,
      "doctorId": doctorId,
      "appointmentTime": appointmentTime,
      "status": 0,
      "insBy": null,
      "updBy": doctorName,
    });
    print('update Schedule $updateScheduleJson');

    bool isUpdateSchedule =
        await _scheduleRepo.updateSchedule(updateScheduleJson);

    if (isUpdateSchedule) {
      print("oke udpate schedule");
      Transaction transactionTemp = new Transaction(
          doctorId: doctorId,
          location: location,
          note: note,
          patientId: patientId,
          status: 4,
          transactionId: transactionID,
          estimatedTime: null);
      bool isUpdateTransaction =
          await _transactionRepo.updateTransaction(transactionTemp);
      if (isUpdateTransaction) {
        print("oke udpate transaction");

        Navigator.pop(context);
        loadBackSchedule();
      }
    }
  }

  Future<void> arrivedTime(
      BuildContext context,
      int patientId,
      String location,
      String note,
      String transactionId,
      int scheduleId,
      String appointmentTime) async {
    waitDialog(context, message: "Loading please wait...");

    Map transactionInfo = {
      "doctor_FBId": userId,
      "transaction_status": "Analysis Symptom",
      "doctor_id": doctorId,
      "patientId": patientId,
      "estimatedTime": null,
      "location": location,
      "note": note,
    };

    await _transactionRequest.child(transactionId).set(transactionInfo);

    String updateScheduleJson = jsonEncode({
      "scheduleId": scheduleId,
      "doctorId": doctorId,
      "appointmentTime": appointmentTime,
      "status": 1,
      "insBy": doctorName,
      "updBy": transactionId,
    });
    print('update Schedule $updateScheduleJson');

    await _scheduleRepo.updateSchedule(updateScheduleJson);

    Transaction transactionTemp = new Transaction(
        doctorId: doctorId,
        location: location,
        note: note,
        patientId: patientId,
        status: 2,
        transactionId: transactionId,
        estimatedTime: null);
    bool isUpdateTransaction =
        await _transactionRepo.updateTransaction(transactionTemp);

    if (isUpdateTransaction) {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BaseTimeLine(transactionId: transactionId),
        ),
      );
    } else {
      print("error Transaction");
    }
  }
}
