import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/home/home_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class LandingPageViewModel extends BaseModel {
  PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<Widget> page = [
    HomeScreen(),
    Text('2'),
    Text('3'),
    Text('4'),
  ];

  List<BottomNavyBarItem> _listItem = [
    BottomNavyBarItem(
        icon: Icon(EvaIcons.cameraOutline),
        title: Text('Doctor'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.gridOutline),
        title: Text('Service'),
        textAlign: TextAlign.center,
        activeColor: Colors.blue[400]),
    BottomNavyBarItem(
        icon: Icon(EvaIcons.calendarOutline),
        title: Text('Appointment'),
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
