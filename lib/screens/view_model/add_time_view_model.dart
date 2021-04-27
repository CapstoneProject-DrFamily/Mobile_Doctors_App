import 'package:intl/intl.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class AddTimeViewModel extends BaseModel {
  bool _isFirstAddTimePopUp = true;
  bool get isFirstAddTimePopUp => _isFirstAddTimePopUp;

  bool _isLoadingAddTimePopUp = true;
  bool get isLoadingAddTimePopUp => _isLoadingAddTimePopUp;
  //0: notChoose
  //1: Choose
  //2: init
  Map<DateTime, int> listTimeDisplay = {};

  Map<DateTime, List<DateTime>> listChoose = {};

  DateFormat timeFormat = DateFormat("HH:mm");

  DateFormat formatInit = DateFormat("yyyy-MM-dd HH:mm");

  int timeGap = 30;

  List<DateTime> listTimeChoose = [];

  List<DateTime> listDaySelected = [];

  bool isRepeat = false;

  Future<void> initAddTime(DateTime time) async {
    if (_isFirstAddTimePopUp) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      String dateStartString = dateFormat.format(time);
      DateTime dateStart = DateTime.parse(dateStartString);
      print('dateStart $dateStart');

      DateFormat dateFormatEnd = DateFormat("yyyy-MM-dd 22:30:00.000");
      String dateEndString = dateFormatEnd.format(time);
      DateTime dateEnd = DateTime.parse(dateEndString);
      print('dateEnd $dateEnd');
      listTimeDisplay.putIfAbsent(dateStart, () => 0);

      // patientModel = await _patientRepo.getPatientInfo(patientId);
      while (dateStart.isBefore(dateEnd)) {
        dateStart = dateStart.add(
          Duration(minutes: timeGap),
        );
        listTimeDisplay.putIfAbsent(dateStart, () => 0);
      }
      // if (listHasChoose != null) {
      //   for (int i = 0; i < listHasChoose.length; i++) {
      //     int index = listTimeDisplay.keys.toList().indexWhere((element) =>
      //         element.isAtSameMomentAs(
      //             DateTime.parse(listHasChoose[i].appointmentTime)));
      //     chooseDateTimeIinit(
      //         DateTime.parse(listHasChoose[i].appointmentTime), index);
      //   }
      // }

      listDaySelected.add(time);

      _isFirstAddTimePopUp = false;
      _isLoadingAddTimePopUp = false;
      notifyListeners();
    }
  }

  void changeSelectedDay(DateTime dateTime, DateTime defaultDate) {
    if (dateTime == defaultDate) {
      return;
    }

    if (this.listDaySelected.contains(dateTime)) {
      this.listDaySelected.removeWhere((element) => element == dateTime);
    } else {
      this.listDaySelected.add(dateTime);
    }

    if (this.listDaySelected.length == 7)
      this.isRepeat = true;
    else
      this.isRepeat = false;
    notifyListeners();
  }

  void chooseDateTimeIinit(DateTime chooseTime, int index) {
    if (listTimeChoose.contains(chooseTime)) {
      listTimeChoose.remove(chooseTime);
      List<DateTime> dateDisable = listChoose[chooseTime];
      print(dateDisable[0]);
      for (int i = 0; i < dateDisable.length; i++) {
        listTimeDisplay.update(dateDisable[i], (value) => 0);
      }
      listTimeDisplay.update(chooseTime, (value) => 0);
      listChoose.removeWhere((key, value) => key == chooseTime);
    } else {
      listTimeChoose.add(chooseTime);
      if (index == 0) {
        List<DateTime> disable = [];
        DateTime timePlus130 = chooseTime.add(Duration(hours: 1, minutes: 30));
        for (int i = 0; i < listTimeDisplay.length; i++) {
          if (listTimeDisplay.keys.toList()[i].isBefore(timePlus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              disable.add(listTimeDisplay.keys.toList()[i]);
              listTimeDisplay.update(
                  listTimeDisplay.keys.toList()[i], (value) => 1);
            }
          }
        }
        listChoose.putIfAbsent(chooseTime, () => disable);
      } else {
        List<DateTime> disable = [];
        DateTime timePlus130 = chooseTime.add(Duration(hours: 1, minutes: 30));

        for (int i = index; i < listTimeDisplay.length; i++) {
          if (listTimeDisplay.keys.toList()[i].isBefore(timePlus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              if (listTimeDisplay.values.toList()[i] == 1) {
              } else {
                disable.add(listTimeDisplay.keys.toList()[i]);
                listTimeDisplay.update(
                    listTimeDisplay.keys.toList()[i], (value) => 1);
              }
            }
          }
        }

        DateTime timeMinus130 =
            chooseTime.subtract(Duration(hours: 1, minutes: 30));
        print(
            "time minus ${timeMinus130.isBefore(listTimeDisplay.keys.toList()[0])}");
        for (int i = index; i >= 0; i--) {
          if (listTimeDisplay.keys.toList()[i].isAfter(timeMinus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              if (listTimeDisplay.values.toList()[i] == 1) {
              } else {
                disable.add(listTimeDisplay.keys.toList()[i]);
                listTimeDisplay.update(
                    listTimeDisplay.keys.toList()[i], (value) => 1);
              }
            }
          }
        }
        listChoose.putIfAbsent(chooseTime, () => disable);
      }
      listTimeDisplay.update(chooseTime, (value) => 2);
      print('list choose add $listChoose');
    }

    notifyListeners();
  }

  void changeRepeat(bool value, DateTime datetime) {
    this.isRepeat = value;
    this.listDaySelected = [];
    if (this.isRepeat) {
      for (var i = 0; i < 7; i++) {
        this.listDaySelected.add(datetime.add(Duration(days: i)));
      }
    } else {
      this.listDaySelected.add(datetime);
    }
    notifyListeners();
  }

  void chooseDateTime(DateTime chooseTime, int index) {
    if (listTimeChoose.contains(chooseTime)) {
      listTimeChoose.remove(chooseTime);
      List<DateTime> dateDisable = listChoose[chooseTime];
      print(dateDisable[0]);
      for (int i = 0; i < dateDisable.length; i++) {
        listTimeDisplay.update(dateDisable[i], (value) => 0);
      }
      listTimeDisplay.update(chooseTime, (value) => 0);
      listChoose.removeWhere((key, value) => key == chooseTime);
    } else {
      listTimeChoose.add(chooseTime);
      if (index == 0) {
        List<DateTime> disable = [];
        DateTime timePlus130 = chooseTime.add(Duration(hours: 1, minutes: 30));
        for (int i = 0; i < listTimeDisplay.length; i++) {
          if (listTimeDisplay.keys.toList()[i].isBefore(timePlus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              disable.add(listTimeDisplay.keys.toList()[i]);
              listTimeDisplay.update(
                  listTimeDisplay.keys.toList()[i], (value) => 1);
            }
          }
        }
        listChoose.putIfAbsent(chooseTime, () => disable);
      } else {
        List<DateTime> disable = [];
        DateTime timePlus130 = chooseTime.add(Duration(hours: 1, minutes: 30));

        for (int i = index; i < listTimeDisplay.length; i++) {
          if (listTimeDisplay.keys.toList()[i].isBefore(timePlus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              if (listTimeDisplay.values.toList()[i] == 1) {
              } else {
                disable.add(listTimeDisplay.keys.toList()[i]);
                listTimeDisplay.update(
                    listTimeDisplay.keys.toList()[i], (value) => 1);
              }
            }
          }
        }

        DateTime timeMinus130 =
            chooseTime.subtract(Duration(hours: 1, minutes: 30));
        print(
            "time minus ${timeMinus130.isBefore(listTimeDisplay.keys.toList()[0])}");
        for (int i = index; i >= 0; i--) {
          if (listTimeDisplay.keys.toList()[i].isAfter(timeMinus130)) {
            if (listTimeDisplay.keys.toList()[i] == chooseTime) {
            } else {
              if (listTimeDisplay.values.toList()[i] == 1) {
              } else {
                disable.add(listTimeDisplay.keys.toList()[i]);
                listTimeDisplay.update(
                    listTimeDisplay.keys.toList()[i], (value) => 1);
              }
            }
          }
        }
        listChoose.putIfAbsent(chooseTime, () => disable);
      }
      listTimeDisplay.update(chooseTime, (value) => 0);
      print('list choose add $listChoose');
    }
    notifyListeners();
  }
}
