import 'dart:convert';
import 'dart:io';
import 'package:mobile_doctors_apps/model/sign_up/create_doctor_model.dart';
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
  CreateDoctorModel _createDoctorModel;
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
  String _dob;
  // String _gender;
  Validate _gender = Validate(null, null);
  String _defaultImage = DEFAULT_IMG;
  String _degree;
  Validate _experience = Validate(null, null);
  Validate _description = Validate(null, null);
  String _school;

  Validate get fullName => _fullName;
  Validate get email => _email;
  Validate get idCard => _idCard;
  String get dob => _dob;
  // String get gender => _gender;
  Validate get gender => _gender;
  String get defaultImage => _defaultImage;
  String get degree => _degree;
  Validate get experience => _experience;
  Validate get description => _description;
  String get school => _school;

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
    'Other',
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
    print(_idSpecialty);
    notifyListeners();
  }

  //function choose school
  void chooseSchool(String newValue) {
    _schoolController.text = newValue;
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
      _error = "Gender is require.";
    }
    notifyListeners();
  }

  void printCheck() {
    print("Image1: " + _image.toString());
    if (_fullName.value == null) {
      checkFullName(null);
    }
    if (_idCard.value == null) {
      checkIDCard(null);
    }

    if (_email.value == null) {
      checkEmail(null);
    }

    if (_experience.value == null) {
      checkExperience(null);
    }

    if (_description.value == null) {
      checkDescription(null);
    }
    // print("ok1");
    if (_genderController.text.isEmpty) {
      print("Gender: " + _genderController.text);
      _gender = Validate(null, "Gender is require.");
      print(_gender.error);
      notifyListeners();
    }
    // print("ok2");
    // notifyListeners();
    // print("name: " + _fullName.value);
    // print("id: " + _idCard.value);
    // print("gender: " + _genderController.text);
    print("dob: " + _dob);
    // print("email: " + _email.value);
    // print("degree: " + _degreeController.text);
    // print("experi: " + _experience.value);
    // print("special: " + _specialtyController.text);
    // print("school: " + _schoolController.text);
    // print("des: " + _description.value);
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

    bool check;
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
        image: currentImage,
        fullName: _fullName.value,
        idCard: _idCard.value,
        gender: _genderController.text,
        dob: _dob,
        phone: phone,
        email: _email.value,
        accountId: accountId,
      );

      String createProfileJson = jsonEncode(_createProfileModel.toJson());
      print("CreateProfileJson: " + createProfileJson + "\n");

      check = await _signUpRepo.createProfile(createProfileJson);
      // if (check == true) check = await _signUpRepo.updateUser();

      profileId = sharedPreferences.getInt('usProfileID');

      _createDoctorModel = new CreateDoctorModel(
        doctorId: profileId,
        degree: _degreeController.text,
        experience: _experience.value,
        description: _description.value,
        specialtyId: _idSpecialty,
        school: _schoolController.text,
      );

      String createDoctorJson = jsonEncode(_createDoctorModel.toJson());
      print("CreateDoctorJson: " + createDoctorJson + "\n");

      if (check == true)
        check = await _signUpRepo.createDoctor(createDoctorJson);

      await sharedPreferences.clear();
    }

    return check;
  }
}
