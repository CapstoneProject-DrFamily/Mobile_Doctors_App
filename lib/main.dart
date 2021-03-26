import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_doctors_apps/screens/history/transaction_detail_page.dart';
import 'package:mobile_doctors_apps/screens/home/home_page.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';
import 'package:mobile_doctors_apps/screens/patient/patient_detail_page.dart';
import 'package:mobile_doctors_apps/screens/schedule/schedule_page.dart';

import 'package:mobile_doctors_apps/screens/share/base_timeline.dart';
import 'package:mobile_doctors_apps/screens/share/health_record_page.dart';

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
        home: profileID == null ? LoginScreen() : LandingScreen()
        // home: HealthRecordScreen(
        //   patientName: "Hoang Duc",
        //   patientId: 25,
        // ),
        // home: TransactionDetailPage(
        //   transactionId: "TS-5e83bdc8-a3e0-48f8-a155-82ef819c09b4",
        // ),
        ),
  );
}
