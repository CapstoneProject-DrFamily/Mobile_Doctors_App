import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/model/schedule_add_model.dart';
import 'package:mobile_doctors_apps/model/schedule_model.dart';
import 'package:mobile_doctors_apps/model/transaction.dart';
import 'package:mobile_doctors_apps/repository/doctor_repo.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/repository/patient_repo.dart';
import 'package:mobile_doctors_apps/repository/schedule_repo.dart';
import 'package:mobile_doctors_apps/repository/sign_up/specialty_repo.dart';
import 'package:mobile_doctors_apps/repository/transaction_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../global_variable.dart';

class SchedulePageViewModel extends BaseModel {
  final IScheduleRepo _scheduleRepo = ScheduleRepo();
  final ITransactionRepo _transactionRepo = TransactionRepo();
  final IPatientRepo _patientRepo = PatientRepo();
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();
  final IExaminationRepo _examinationRepo = ExaminationRepo();

  bool isLoading = true;
  bool isFirst = true;
  bool isNotHave = false;
  bool isAdd = true;
  bool isDelete = true;
  bool loadingListTransaction = false;

  String dateTime;

  Map<DateTime, List> _events = {};
  Map<DateTime, List> get events => _events;
  List _selectedEvents = [];
  List get selectedEvents => _selectedEvents;

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
  DateTime get changeDate => _changeDate;

  DatabaseReference _transactionRequest;
  FirebaseUser _firebaseuser;
  String userId;
  int specialtyId;
  int serviceId;

  Future<void> initScheduleToday() async {
    if (isFirst) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorId = prefs.getInt("doctorId");
      doctorName = prefs.getString("usName");
      loadingListTransaction = true;

      specialtyId = await _doctorRepo.getSpecialtyId(doctorId);
      serviceId = await _specialtyRepo.getServiceIdBySpecialtyId(specialtyId);
      print("oke");

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
    // print(
    //     'selected event ${_selectedEvents[0].transactionScheduleModel.location}');

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

  //add ScheduleTime
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
          //add transaction
          String transaction = jsonEncode({
            "doctorId": doctorId,
            "patientId": null,
            "status": 0,
            "location": null,
            "note": "Nothing",
            "serviceId": serviceId,
          });

          print("transaction: " + transaction);
          String transactionId =
              await _transactionRepo.addBookingTransaction(transaction);

          //add schedule
          bool status = await addSchedule(dateChoose, transactionId);

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

  Future<bool> addSchedule(DateTime dateChoose, String transactionId) async {
    ScheduleAddModel addScheduleModel = ScheduleAddModel(
        scheduleId: transactionId,
        appointmentTime: dateChoose.toString(),
        doctorId: doctorId,
        insBy: doctorName,
        status: false,
        disable: false);
    String jsonSchedule = jsonEncode(addScheduleModel.toJson());
    print('jsonSchedule: $jsonSchedule');
    bool status = await _scheduleRepo.createSchedule(jsonSchedule);
    return status;
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
  //end Add schedule

  //addMultipleShedule
  void addMultipleSchedule(
      List<DateTime> timeChoose, BuildContext context) async {
    waitDialog(context, message: "Setting your Schedule please wait...");

    var listTimeChoose = timeChoose;
    // List<TransactionTemp> listTransaction = [];
    List<ScheduleAddModel> listSchedule = [];
    // for (var item in listTimeChoose) {
    //   listTransaction
    //       .add(TransactionTemp(doctorId: doctorId, serviceID: serviceId));
    // }

    // String transactionJson = jsonEncode(listTransaction);

    // print("transactionjson $transactionJson");

    // List<String> transactionId =
    //     await _transactionRepo.addListTransaction(transactionJson);
    // print("listTransactionIdAPI: $transactionId");

    // if (transactionId == null) {
    //   //error
    //   Navigator.pop(context);
    //   Navigator.pop(context);

    //   Fluttertoast.showToast(
    //     msg: "Error please try agian.",
    //     textColor: Colors.red,
    //     toastLength: Toast.LENGTH_LONG,
    //     backgroundColor: Colors.white,
    //     gravity: ToastGravity.CENTER,
    //   );
    // }

    for (int i = 0; i < listTimeChoose.length; i++) {
      ScheduleAddModel addScheduleModel = ScheduleAddModel(
          scheduleId: "0",
          appointmentTime: listTimeChoose[i].toString(),
          doctorId: doctorId,
          insBy: doctorName,
          status: false,
          disable: false);
      listSchedule.add(addScheduleModel);
    }

    String scheduleJson = jsonEncode(listSchedule);

    print("listScheduleJson: $scheduleJson");

    bool isAdd = await _scheduleRepo.createSchedule(scheduleJson);

    if (isAdd) {
      //oke
      Navigator.pop(context);
      Navigator.pop(context);
      CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.success,
          text: "Update your schedule success",
          backgroundColor: Colors.lightBlue[200]);

      loadBackSchedule();
    } else {
      Navigator.pop(context);
      Navigator.pop(context);

      CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "False to udpate schedule!",
          backgroundColor: Colors.lightBlue[200]);
      //error
    }
  }

  Future<void> callPhone(int patientId, String time) async {
    var phone = await _patientRepo.getPatientPhone(patientId);
    print('phone $phone');

    await launch('tel://$phone');
  }

  Future<void> deleteScheduleNoTask(
      int scheduleId, BuildContext context) async {
    waitDialog(context, message: "Deleting your booking please wait...");

    bool isDelete = await _scheduleRepo.deleteScheduleNoTask(scheduleId);
    // bool isDeleteTransaction =
    //     await _transactionRepo.deleteTransaction(scheduleId);
    if (isDelete) {
      Navigator.pop(context);
      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Update schedule Success!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
      loadBackSchedule();
    } else {
      Navigator.pop(context);

      CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.error,
        text: "Sorry, something is went wrong please try again!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
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
      Navigator.pop(context);
      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Update schedule Success!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
      loadBackSchedule();
    } else {
      Navigator.pop(context);

      CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.error,
        text: "Sorry, something is went wrong please try again!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
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
    Transaction transactionTemp = new Transaction(
        doctorId: doctorId,
        location: null,
        note: "Nothing",
        patientId: null,
        status: 4,
        transactionId: transactionID,
        estimatedTime: null);
    bool isUpdateTransaction =
        await _transactionRepo.updateTransaction(transactionTemp);

    if (isUpdateSchedule && isUpdateTransaction) {
      print("oke udpate transaction");
      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Cancel booking Success!",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );

      Navigator.pop(context);
      loadBackSchedule();
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(
        msg: "Sorry, something is went please try again",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
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

    await _examinationRepo.createNewExamination(transactionId, doctorName);

    Transaction transactionTemp = new Transaction(
        doctorId: doctorId,
        location: location,
        note: note,
        patientId: patientId,
        status: 2,
        transactionId: transactionId,
        estimatedTime: null,
        scheduleId: scheduleId);
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
      Fluttertoast.showToast(
        msg: "Sorry, something is went please try again",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}

class TransactionTemp {
  final int doctorId, serviceID;
  TransactionTemp({this.doctorId, this.serviceID});

  Map<String, dynamic> toJson() => {
        "doctorId": this.doctorId,
        "patientId": null,
        "status": 0,
        "location": null,
        "note": "Nothing",
        "serviceId": this.serviceID,
      };
}
