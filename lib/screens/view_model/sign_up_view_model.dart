import 'dart:convert';
import 'dart:io';
import 'package:mobile_doctors_apps/model/sign_up/create_profile_model.dart';
import 'package:mobile_doctors_apps/model/sign_up/specialty_sign_up_model.dart';
import 'package:mobile_doctors_apps/repository/sign_up/sign_up_repo.dart';
import 'package:mobile_doctors_apps/repository/sign_up/specialty_repo.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_doctors_apps/helper/app_image.dart';
import 'package:mobile_doctors_apps/helper/validate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../share/base_view.dart';

class SignUpViewModel extends BaseModel {
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();
  ISignUpRepo _signUpRepo = SignUpRepo();
  CreateProfileModel _createProfileModel;
  String phone;
  int profileId;

  //TextEditingController
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idCardController = TextEditingController();
  TextEditingController _specialtyController = TextEditingController();
  TextEditingController _degreeController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get dobController => _dobController;
  TextEditingController get genderController => _genderController;
  TextEditingController get emailController => _emailController;
  TextEditingController get idCardController => _idCardController;
  TextEditingController get specialtyController => _specialtyController;
  TextEditingController get degreeController => _degreeController;
  TextEditingController get experienceController => _experienceController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get schoolController => _schoolController;

  Validate _fullName = Validate(null, null);
  Validate _email = Validate(null, null);
  Validate _idCard = Validate(null, null);
  Validate _checkDOB = Validate(null, null);
  String _dob;
  Validate _gender = Validate(null, null);
  String _defaultImage = DEFAULT_IMG;
  Validate _degree = Validate(null, null);
  Validate _experience = Validate(null, null);
  Validate _description = Validate(null, null);
  Validate _specialty = Validate(null, null);
  Validate _school = Validate(null, null);

  Validate get fullName => _fullName;
  Validate get email => _email;
  Validate get idCard => _idCard;
  Validate get checkDOB => _checkDOB;
  String get dob => _dob;
  Validate get gender => _gender;
  String get defaultImage => _defaultImage;
  Validate get degree => _degree;
  Validate get experience => _experience;
  Validate get description => _description;
  Validate get specialty => _specialty;
  Validate get school => _school;

  File _image;
  File get image => _image;

  List<SpecialtyModel> _listSpecialty = [];
  List<SpecialtyModel> get listSpecialty => _listSpecialty;

  List<String> _listSpecialtyName = [];
  List<String> get listSpecialtyName => _listSpecialtyName;
  int _idSpecialty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNotHave = false;
  bool get isNotHave => _isNotHave;

  bool _check;
  bool get check => _check;

  List<String> _genderList = [
    'Male',
    'Female',
  ];
  List<String> get genderList => _genderList;

  List _months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];

  List<String> _listDegree = [
    'Bachelor',
    'Bachelor of Medicine',
    'Bachelor of Medical Sciences',
    'Bachelor of Public Health',
    'Bachelor of Surgery',
    'Doctor of Medicine',
    'Other',
  ];

  List<String> _listSchool = [
    'Hanoi Medical University',
    'University of Medicine And Pharmacy at HCMC',
    'University of Medicine Pham Ngoc Thach',
    'Hai Phong University of Medicine And Pharmacy',
    'Thai Binh University of Medicine And Pharmacy',
    'Vinh Medical University',
    'Can Tho University of Medicine And Pharmacy',
    'Other',
  ];

  List<String> get listDegree => _listDegree;
  List<String> get listSchool => _listSchool;

  SignUpViewModel() {
    getUserPhoneNum();
    getListSpecialty();
  }

  //function get user phone number in SharedPreferences
  void getUserPhoneNum() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    phone = sharedPreferences.getString('usPhone');
    notifyListeners();
  }

  void checkFullName(String fullName) {
    if (fullName == null || fullName.length == 0) {
      _fullName = Validate(null, "Fullname can't be blank");
    } else {
      _fullName = Validate(fullName, null);
    }
    notifyListeners();
  }

  void checkIDCard(String idCard) {
    print(idCard);
    if (idCard == null || idCard.length == 0) {
      _idCard = Validate(null, "Social Security Number can't be blank");
    } else {
      _idCard = Validate(idCard, null);
    }
    notifyListeners();
  }

  //function choose gender
  void chooseGender(String newValue) {
    _genderController.text = newValue;
    _gender = Validate(newValue, null);
    notifyListeners();
  }

  //function choose DOB
  void changeDOB(DateTime datetime) {
    if (datetime.day < 10) {
      _dobController.text = "0" +
          datetime.day.toString() +
          '-' +
          _months[datetime.month - 1] +
          '-' +
          datetime.year.toString();
    } else {
      _dobController.text = datetime.day.toString() +
          '-' +
          _months[datetime.month - 1] +
          '-' +
          datetime.year.toString();
    }
    _dob = datetime.year.toString() +
        '-' +
        _months[datetime.month - 1] +
        '-' +
        datetime.day.toString();
    _checkDOB = Validate(_dob, null);
    notifyListeners();
  }

  void checkEmail(String email) {
    String check = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(check);
    if (email == null || email.length == 0) {
      _email = Validate(null, "Email can't be blank");
    } else if (!regExp.hasMatch(email)) {
      _email = Validate(null, "Invalid Email!");
    } else {
      _email = Validate(email, null);
    }
    notifyListeners();
  }

  //function choose degree
  void chooseDegree(String newValue) {
    _degreeController.text = newValue;
    _degree = Validate(newValue, null);
    print("Degree: " + _degreeController.text);
    notifyListeners();
  }

  void checkExperience(String experience) {
    print(experience);
    if (experience == null || experience.length == 0) {
      _experience = Validate(null, "Experience can't be blank");
    } else {
      _experience = Validate(experience, null);
    }
    notifyListeners();
  }

  //function choose specialty and get selected specialtyId
  void chooseSpecialty(String newValue) {
    _specialtyController.text = newValue;
    _idSpecialty =
        _listSpecialty[_listSpecialtyName.indexOf(newValue)].specialtyId;
    _specialty = Validate(newValue, null);
    print(_idSpecialty);
    notifyListeners();
  }

  //function choose school
  void chooseSchool(String newValue) {
    _schoolController.text = newValue;
    _school = Validate(newValue, null);
    print("School: " + _schoolController.text);
    notifyListeners();
  }

  void checkDescription(String description) {
    print(description);
    if (description == null || description.length == 0) {
      _description = Validate(null, "Description can't be blank");
    } else {
      _description = Validate(description, null);
    }
    notifyListeners();
  }

  Future<void> getListSpecialty() async {
    this._isLoading = true;
    notifyListeners();

    _listSpecialty = await _specialtyRepo.getAllSpecialty().whenComplete(() {
      this._isLoading = false;
      notifyListeners();
    });

    if (_listSpecialty == null) {
      _isNotHave = true;
      notifyListeners();
    }

    for (int i = 0; i < _listSpecialty.length; i++) {
      _listSpecialtyName.add(_listSpecialty[i].specialtyTitle);
    }
  }

  String _error;
  String get error => _error;

  void checkGender() {
    if (_genderController.text.isEmpty) {
      _gender = Validate(null, "Gender is require.");
    }
    notifyListeners();
  }

  void checkDob() {
    if (_dobController.text.isEmpty) {
      _checkDOB = Validate(null, "Birthday is require.");
    }
    notifyListeners();
  }

  void checkDegree() {
    if (_degreeController.text.isEmpty) {
      _degree = Validate(null, "Degree is require.");
    }
    notifyListeners();
  }

  void checkSpecialty() {
    if (_specialtyController.text.isEmpty) {
      _specialty = Validate(null, "Specialty is require.");
    }
    notifyListeners();
  }

  void checkSchool() {
    if (_schoolController.text.isEmpty) {
      _school = Validate(null, "School is require.");
    }
    notifyListeners();
  }

  void printCheck() {
    _isReady = true;
    checkGender();
    checkDob();
    checkDegree();
    checkSpecialty();
    checkSchool();

    if (_fullName.value == null) {
      checkFullName(null);
      _isReady = false;
    }
    if (_idCard.value == null) {
      checkIDCard(null);
      _isReady = false;
    }
    if (_email.value == null) {
      checkEmail(null);
      _isReady = false;
    }
    if (_experience.value == null) {
      checkExperience(null);
      _isReady = false;
    }
    if (_description.value == null) {
      checkDescription(null);
      _isReady = false;
    }
    if (_gender.value == null) _isReady = false;
    if (_checkDOB.value == null) _isReady = false;
    if (_degree.value == null) _isReady = false;
    if (_specialty.value == null) _isReady = false;
    if (_specialty.value == null) _isReady = false;

    print("_isReady: " + _isReady.toString());
  }

  Future getUserImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    notifyListeners();
  }

  Future<String> upLoadImage() async {
    String basename = path.basename(_image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child("DoctorStorage/" + basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  bool _isReady;
  bool get isReady => _isReady;

  Future<bool> createNewDoctorAccount() async {
    _isReady = true;
    checkGender();
    checkDob();
    checkDegree();
    checkSpecialty();
    checkSchool();

    if (_fullName.value == null) {
      checkFullName(null);
      _isReady = false;
    }
    if (_idCard.value == null) {
      checkIDCard(null);
      _isReady = false;
    }
    if (_email.value == null) {
      checkEmail(null);
      _isReady = false;
    }
    if (_experience.value == null) {
      checkExperience(null);
      _isReady = false;
    }
    if (_description.value == null) {
      checkDescription(null);
      _isReady = false;
    }
    if (_gender.value == null) _isReady = false;
    if (_checkDOB.value == null) _isReady = false;
    if (_degree.value == null) _isReady = false;
    if (_specialty.value == null) _isReady = false;
    if (_school.value == null) _isReady = false;

    bool check = false;
    if (_isReady == true) {
      String currentImage;

      if (_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var accountId = sharedPreferences.getInt('usAccountID');

      _createProfileModel = new CreateProfileModel(
        accountId: accountId,
        image: currentImage,
        fullName: _fullName.value,
        idCard: _idCard.value,
        gender: _genderController.text,
        dob: _dob,
        phone: phone,
        email: _email.value,
        degree: _degreeController.text,
        experience: _experience.value,
        description: _description.value,
        specialtyId: _idSpecialty,
        school: _schoolController.text,
      );

      String createDoctorProfileJson = jsonEncode(_createProfileModel.toJson());
      print("CreateDoctorProfileJson: " + createDoctorProfileJson + "\n");

      check = await _signUpRepo.createDoctorProfile(createDoctorProfileJson);
    }

    return check;
  }
}
