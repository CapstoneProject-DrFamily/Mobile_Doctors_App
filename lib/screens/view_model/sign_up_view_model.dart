import 'dart:convert';
import 'dart:io';
import 'package:mobile_doctors_apps/model/sign_up/create_doctor_model.dart';
import 'package:mobile_doctors_apps/model/sign_up/create_profile_model.dart';
import 'package:mobile_doctors_apps/model/sign_up/specialty_sign_up_model.dart';
import 'package:mobile_doctors_apps/model/sign_up/update_user_model.dart';
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
  String _gender;
  String _defaultImage = DEFAULT_IMG;
  Validate _degree = Validate(null, null);
  Validate _experience = Validate(null, null);
  Validate _description = Validate(null, null);
  Validate _school = Validate(null, null);

  Validate get fullName => _fullName;
  Validate get email => _email;
  Validate get idCard => _idCard;
  String get dob => _dob;
  String get gender => _gender;
  String get defaultImage => _defaultImage;
  Validate get degree => _degree;
  Validate get experience => _experience;
  Validate get description => _description;
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

  SignUpViewModel() {
    //
    _dobController.addListener(() {
      _dob = _dobController.text;
      notifyListeners();
    });
    //
    _genderController.addListener(() {
      _gender = _genderController.text;
      notifyListeners();
    });

    getUserPhoneNum();
    getListSpecialty();
  }

  //function get data in Shared
  // void getData() async{
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   profileId = sharedPreferences.getInt('usProfileID');
  // }

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

  //function choose specialty and get selected specialtyId
  void chooseSpecialty(String newValue) {
    _specialtyController.text = newValue;
    _idSpecialty =
        _listSpecialty[_listSpecialtyName.indexOf(newValue)].specialtyId;
    print(_idSpecialty);
    notifyListeners();
  }

  //function get user phone number in SharedPreferences
  void getUserPhoneNum() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    phone = sharedPreferences.getString('usPhone');
    notifyListeners();
  }

  //function choose DOB
  void changeDOB(DateTime datetime) {
    _dobController.text = datetime.year.toString() +
        '-' +
        _months[datetime.month - 1] +
        '-' +
        datetime.day.toString();
    notifyListeners();
  }

  //function choose gender
  void chooseGender(String newValue) {
    _genderController.text = newValue;
    notifyListeners();
  }

  void checkFullName(String fullName) {
    print(fullName);
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
      _idCard = Validate(null, "ID Card can't be blank");
    } else {
      _idCard = Validate(idCard, null);
    }
    notifyListeners();
  }

  void checkEmail(String email) {
    print(email);
    if (email == null || email.length == 0) {
      _email = Validate(null, "Email can't be blank");
    } else {
      _email = Validate(email, null);
    }
    notifyListeners();
  }

  void checkDegree(String degree) {
    print(degree);
    if (degree == null || degree.length == 0) {
      _degree = Validate(null, "Degree can't be blank");
    } else {
      _degree = Validate(degree, null);
    }
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

  void checkSchool(String school) {
    print(school);
    if (school == null || school.length == 0) {
      _school = Validate(null, "School can't be blank");
    } else {
      _school = Validate(school, null);
    }
    notifyListeners();
  }

  void printCheck() {
    print(_image.toString());
    print(_fullName.value);
    print(_idCard.value);
    print(_gender);
    print(_dob);
    print(_email.value);
    print(_degree.value);
    print(_experience.value);
    print(_description.value);
    print(_specialtyController.text);
    print(_school.value);
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

  Future<bool> createNewDoctorAccount() async {
    _check = true;
    if (_fullName.value == null) {
      checkFullName(null);
      _check = false;
    }

    if (check == true) {
      String currentImage;

      if (_image != null) {
        var url = await upLoadImage();
        currentImage = url.toString();
      } else {
        currentImage = defaultImage;
      }

      _createProfileModel = new CreateProfileModel(
        fullName: _fullName.value,
        dob: _dob,
        gender: _gender,
        phone: phone,
        image: currentImage,
        email: _email.value,
        idCard: _idCard.value,
      );

      String createProfileJson = jsonEncode(_createProfileModel.toJson());
      print("CreateProfileJson: " + createProfileJson + "\n");

      bool check = await _signUpRepo.createProfile(createProfileJson);
      if (check == true) check = await _signUpRepo.updateUser();

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      profileId = sharedPreferences.getInt('usProfileID');

      _createDoctorModel = new CreateDoctorModel(
        degree: _degree.value,
        experience: _experience.value,
        description: _description.value,
        profileId: profileId,
        specialtyId: _idSpecialty,
        school: _school.value,
      );

      String createDoctorJson = jsonEncode(_createDoctorModel.toJson());
      print("CreateDoctorJson: " + createDoctorJson + "\n");

      if (check == true)
        check = await _signUpRepo.createDoctor(createDoctorJson);
      sharedPreferences.remove("usProfileID");
    }

    return check;
  }
}
