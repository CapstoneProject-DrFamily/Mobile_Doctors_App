import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewModel extends BaseModel {
  Future<void> signOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}
