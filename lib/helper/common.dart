import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Common {
  static Color completeColor = Colors.lightBlue[700];
  static Color inProgressColor = Colors.lightBlue;
  static Color todoColor = Color(0xff5e6172);

  static Color getColor(int index, int _processIndex) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  static String convertDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String month;
    switch (dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    String display = dateTime.day.toString() +
        "-" +
        month +
        " " +
        dateTime.hour.toString() +
        ":" +
        dateTime.minute.toString();

    return display;
  }

  static String getLocationName(String data) {
    var list = data.split(";");
    var temp = list[1].split(":");
    return temp[1];
  }

  static String convertPrice(double price) {
    return NumberFormat.currency(locale: 'vi').format(price);
  }
}
