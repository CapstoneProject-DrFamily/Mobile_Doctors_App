import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class ProfilePageViewModel extends BaseModel {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _identityNumberController = TextEditingController();
  TextEditingController _bloodTpeController = TextEditingController();

  List<String> degrees = [];

  String _dob = "";
  String _fullName = "";
  String _phoneNum = "";
  String _email = "";
  String _identityNum = "";
  String _bloodType = "";
  String _height = "";
  String _weight = "";

  int _gender = 0;
  List _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  //getter
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get dobController => _dobController;
  TextEditingController get phoneNumController => _phoneNumController;
  TextEditingController get emailController => _emailController;
  TextEditingController get identityNumberController =>
      _identityNumberController;
  TextEditingController get bloodTpeController => _bloodTpeController;

  String get fullName => _fullName;
  String get dob => _dob;
  String get phoneNum => _phoneNum;
  String get email => _email;
  String get identityNum => _identityNum;
  String get bloodType => _bloodType;
  String get height => _height;
  String get weight => _weight;

  int get gender => _gender;

  ProfilePageViewModel() {
    _fullNameController.addListener(() {
      _fullName = _fullNameController.text;
      notifyListeners();
    });
    _dobController.addListener(() {
      _dob = _dobController.text;
      notifyListeners();
    });
    _phoneNumController.addListener(() {
      _phoneNum = _phoneNumController.text;
      notifyListeners();
    });
    _emailController.addListener(() {
      _email = _emailController.text;
      notifyListeners();
    });
    _identityNumberController.addListener(() {
      _identityNum = _identityNumberController.text;
      notifyListeners();
    });
    _bloodTpeController.addListener(() {
      _bloodType = _bloodTpeController.text;
      notifyListeners();
    });
  }

  void changeGender(int gen) {
    print(gen);
    _gender = gen;
    notifyListeners();
  }

  void changeDOB(DateTime datetime) {
    _dobController.text = datetime.year.toString() +
        '-' +
        _months[datetime.month - 1] +
        '-' +
        datetime.day.toString();
    notifyListeners();
  }

  void addListDegrees() {
    degrees.add("value");
    notifyListeners();
  }

  void removeDegrees(int index) {
    print(index);
    degrees.removeAt(index);
    notifyListeners();
  }
}
