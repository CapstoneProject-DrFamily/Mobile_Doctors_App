import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/helper/validate.dart';
import 'package:mobile_doctors_apps/screens/login/verify_otp.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends BaseModel {
  TextEditingController phoneNo;

  Validate _phoneNum = Validate(null, null);
  Validate get phoneNum => _phoneNum;

  Future storePhone(BuildContext context) async {
    if (_phoneNum.value != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("usPhone", phoneNum.value);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(),
        ),
      );
    } else {
      return;
    }
  }

  void changePhoneNum(String value) {
    if (value.length < 9) {
      _phoneNum = Validate(null, "Require at least 9 number");
    } else {
      _phoneNum = Validate(value, null);
    }
    notifyListeners();
  }
}
