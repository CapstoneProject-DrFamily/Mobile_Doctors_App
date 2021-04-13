import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';
import 'package:mobile_doctors_apps/screens/sign_up/sign_up.dart';

import 'package:mobile_doctors_apps/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var profileID = prefs.getInt('usProfileID');

  await setupLocator();

  runApp(
    GetMaterialApp(
        theme: ThemeData(fontFamily: 'VarelaRound'),
        debugShowCheckedModeBanner: false,
        home: (profileID == 0 || profileID == null)
            ? LoginScreen()
            : LandingScreen()
        // home: SignUpPage(),
        ),
  );
}
