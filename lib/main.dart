import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';

import 'package:mobile_doctors_apps/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var accountID = prefs.getInt('usAccountID');

  await setupLocator();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: accountID == null ? LoginScreen() : LandingScreen(),
    ),
  );
}
