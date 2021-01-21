import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/landing/landing_page.dart';

import 'package:mobile_doctors_apps/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //render
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: LandingScreen());
  }
}
