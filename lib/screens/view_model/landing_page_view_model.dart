import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/history/medical_care_history.dart';
import 'package:mobile_doctors_apps/screens/home/home_page.dart';
import 'package:mobile_doctors_apps/screens/schedule/schedule_page.dart';
import 'package:mobile_doctors_apps/screens/setting/setting_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class LandingPageViewModel extends BaseModel {
  PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<Widget> page = [
    HomePage(),
    SchedulePage(),
    MedicalCareHistory(),
    SettingPage(),
  ];

  LandingPageViewModel() {
    // init();
  }

  // Future<void> init() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String phone = prefs.getString("usPhone");
  //   int profileID = prefs.get("usProfileID");
  //   int userID = prefs.get("usAccountID");

  //   print("Phone: " +
  //       phone +
  //       " ProfileID: " +
  //       profileID.toString() +
  //       " AccountID: " +
  //       userID.toString());
  // }

  List<BottomNavyBarItem> _listItem = [
    BottomNavyBarItem(
        icon: Icon(EvaIcons.cameraOutline),
        title: Text('Doctor'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.calendarOutline),
        title: Text('Appointment'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.clockOutline),
        title: Text('Record'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.settingsOutline),
        title: Text('Setting'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400])
  ];

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  //getters
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;
  List<BottomNavyBarItem> get listItem => _listItem;
}
