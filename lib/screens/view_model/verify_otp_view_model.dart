import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOTPViewModel extends BaseModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _smsOTP;
  String _verificationId;
  String errorMessage = '';
  bool loading = false;
  String _phoneNum;

  FocusNode pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  String _number1;
  String _number2;
  String _number3;
  String _number4;
  String _number5;
  String _number6;
  bool _hideResend;
  int _start;
  Timer _timer;
  int _inittimer = 59;

  //getters
  bool get hideResend => _hideResend;
  int get start => _start;
  Timer get timer => _timer;
  String get phoneNum => _phoneNum;

  void startTimer() {
    this._hideResend = true;
    this._start = _inittimer;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          this._hideResend = false;
          timer.cancel();
          notifyListeners();
        } else {
          _start--;
          if (_start == 58) {
            // verifyPhone(_phoneNum);
            print(_phoneNum);
          }
          notifyListeners();
        }
      },
    );
  }

  VerifyOTPViewModel() {
    getSimpleInfo();
    this._hideResend = true;
    this._start = _inittimer;
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    startTimer();
  }

  void getSimpleInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _phoneNum = prefs.getString("usPhone");
    if (_phoneNum[0].endsWith('0'))
      _phoneNum = _phoneNum.substring(1, _phoneNum.length);
    notifyListeners();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1 || value.length == 0) {
      focusNode.requestFocus();
      notifyListeners();
    }
  }

  FocusNode nextFocusNode(int value) {
    switch (value) {
      case 1:
        return pin1FocusNode;
        break;
      case 2:
        return pin2FocusNode;
        break;
      case 3:
        return pin3FocusNode;
        break;
      case 4:
        return pin4FocusNode;
        break;
      case 5:
        return pin5FocusNode;
        break;
      case 6:
        return pin6FocusNode;
        break;
      default:
        return null;
    }
  }

  void changeFocusNode(int field, String value) {
    if (value == '') {
      switch (field) {
        case 1:
          pin1FocusNode.unfocus();
          _number1 = value;
          break;
        case 2:
          nextField(value: value, focusNode: pin1FocusNode);
          _number2 = value;
          break;
        case 3:
          nextField(value: value, focusNode: pin2FocusNode);
          _number3 = value;
          break;
        case 4:
          nextField(value: value, focusNode: pin3FocusNode);
          _number4 = value;
          break;
        case 5:
          nextField(value: value, focusNode: pin4FocusNode);
          _number5 = value;
          break;
        case 6:
          nextField(value: value, focusNode: pin5FocusNode);
          _number6 = value;
          break;
        default:
      }
    } else
      switch (field) {
        case 1:
          nextField(value: value, focusNode: pin2FocusNode);
          _number1 = value;
          break;
        case 2:
          nextField(value: value, focusNode: pin3FocusNode);
          _number2 = value;
          break;
        case 3:
          nextField(value: value, focusNode: pin4FocusNode);
          _number3 = value;
          break;
        case 4:
          nextField(value: value, focusNode: pin5FocusNode);
          _number4 = value;
          break;
        case 5:
          nextField(value: value, focusNode: pin6FocusNode);
          _number5 = value;
          break;
        case 6:
          pin6FocusNode.unfocus();
          _number6 = value;
          break;
        default:
      }
    notifyListeners();
  }

  void submitOTP(BuildContext context) async {
    _smsOTP = _number1 + _number2 + _number3 + _number4 + _number5 + _number6;
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: _verificationId, smsCode: _smsOTP);
      await _auth.signInWithCredential(credential).then(
        (value) async {
          if (value.user != null)
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {}),
                (Route<dynamic> route) => false);
        },
      );
    } catch (e) {
      print("${e.toString()}");
      FocusScope.of(context).unfocus();
      Fluttertoast.showToast(
        msg: "Invalid OTP",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  handleError(error) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  Future<void> verifyPhone(String number) async {
    final PhoneCodeSent smsOTPSent = (String verID, [int fourceCodeResend]) {
      this._verificationId = verID;
    };
    try {
      if (number[0].endsWith('0')) number = number.substring(1, number.length);
      await _auth.verifyPhoneNumber(
          phoneNumber: '+84' + number.trim(),
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException ex) {
            print('${ex.message} + something is wrong');
          },
          codeSent: smsOTPSent,
          codeAutoRetrievalTimeout: (String verID) {
            this._verificationId = verID;
          });
    } catch (e) {
      handleError(e);
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
