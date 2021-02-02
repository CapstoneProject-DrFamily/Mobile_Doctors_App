import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';

class ProfilePageViewModel extends BaseModel {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _identityNumberController = TextEditingController();
  TextEditingController _specialityTpeController = TextEditingController();
  TextEditingController _experienceTypeController = TextEditingController();
  TextEditingController _graduatedController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();

  List<String> degrees = [];

  String _dob = "";
  String _fullName = "";
  String _phoneNum = "";
  String _email = "";
  String _identityNum = "";
  String _specialityType = "";
  String _experience = "";
  String _graduated = "";
  String _description = "";
  String _degree = "";

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

  List<String> listSpeciality = [
    'Khoa nội',
    'Khoa ngoại',
    'Khoa nhi',
    'Khoa sản'
  ];

  //getter
  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get dobController => _dobController;
  TextEditingController get phoneNumController => _phoneNumController;
  TextEditingController get emailController => _emailController;
  TextEditingController get identityNumberController =>
      _identityNumberController;
  TextEditingController get specialityTpeController => _specialityTpeController;
  TextEditingController get experienceTypeController =>
      _experienceTypeController;
  TextEditingController get graduatedController => _graduatedController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get degreeController => _degreeController;

  String get fullName => _fullName;
  String get dob => _dob;
  String get phoneNum => _phoneNum;
  String get email => _email;
  String get identityNum => _identityNum;
  String get specialityType => _specialityType;
  String get experienceType => _experience;
  String get graduated => _graduated;
  String get description => _description;
  String get degree => _degree;

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
    _descriptionController.addListener(() {
      _description = _emailController.text;
      notifyListeners();
    });

    _degreeController.addListener(() {
      _degree = _degreeController.text;
      notifyListeners();
    });
    _experienceTypeController.addListener(() {
      _experience = _experienceTypeController.text;
      notifyListeners();
    });

    _graduatedController.addListener(() {
      _graduated = _graduatedController.text;
      notifyListeners();
    });

    _identityNumberController.addListener(() {
      _identityNum = _identityNumberController.text;
      notifyListeners();
    });
    _specialityTpeController.addListener(() {
      _specialityType = _specialityTpeController.text;
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

  void changeSpecialityType(String type) {
    _specialityTpeController.text = type;
    notifyListeners();
  }
}
