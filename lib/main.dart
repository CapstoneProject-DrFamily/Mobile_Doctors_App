import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/record/sample_page.dart';
import 'package:mobile_doctors_apps/screens/setting/setting_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';

import 'package:mobile_doctors_apps/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var profileID = prefs.getInt('usProfileID');

  await setupLocator();

  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: profileID == null ? LoginScreen() : LandingScreen()
        // home: BaseTimeLine(
        //   transactionId: "TS-1387c26f-f89a-43e7-a907-e7d20aff2542",
        // ),
        ),
  );
}
