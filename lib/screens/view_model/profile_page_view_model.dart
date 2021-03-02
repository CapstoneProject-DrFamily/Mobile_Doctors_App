import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_doctors_apps/model/doctor_detail.dart';
import 'package:mobile_doctors_apps/model/sign_up/specialty_sign_up_model.dart';
import 'package:mobile_doctors_apps/model/specialty_model.dart';
import 'package:mobile_doctors_apps/model/user_profile.dart';
import 'package:mobile_doctors_apps/repository/doctor_repo.dart';
import 'package:mobile_doctors_apps/repository/sign_up/specialty_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class ProfilePageViewModel extends BaseModel {
  final IDoctorRepo _doctorRepo = DoctorRepo();
  final ISpecialtyRepo _specialtyRepo = SpecialtyRepo();

  final TextEditingController _fullNameController = TextEditingController();
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

  DoctorDetail doctorDetail;
  UserProfile userProfile;

  String defaultImage = "";
  int specialtyId;

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

  List<String> listSpeciality = [];

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
  File _image;
  File get image => _image;

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

    fetchProfileData();
  }

  Future<bool> fetchProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // mock
    prefs.setInt("doctorId", 17);
    //
    int doctorId = prefs.getInt("doctorId");

    var res = await _doctorRepo.getDoctorDetail(doctorId);
    if (res != null) {
      doctorDetail = res[0];
      userProfile = res[1];
      transferToViewModel(doctorDetail, userProfile);
    }
    return null;
  }

  Future<void> transferToViewModel(
      DoctorDetail doctorDetail, UserProfile userProfile) async {
    fullNameController.text = userProfile.fullName;
    // miss gender, birthday, sle
    if (userProfile.gender.toLowerCase().trim() == 'male') {
      changeGender(0);
    } else if (userProfile.gender.toLowerCase().trim() == 'female') {
      changeGender(1);
    } else
      changeGender(2);

    defaultImage = userProfile.image;

    phoneNumController.text = userProfile.phone;
    emailController.text = userProfile.email;
    identityNumberController.text = userProfile.idCard;

    degreeController.text = doctorDetail.degree;
    specialtyId = doctorDetail.specialtyId;
    experienceTypeController.text = doctorDetail.experience;
    graduatedController.text = doctorDetail.school;
    descriptionController.text = doctorDetail.description;
    DateTime date = DateTime.parse(userProfile.birthday);
    changeDOB(date);

    List<SpecialtyModel> list = await _specialtyRepo.getAllSpecialty();
    for (var i = 0; i < list.length; i++) {
      listSpeciality.add(list[i].specialtyTitle);
      if (list[i].specialtyId == specialtyId) {
        specialityTpeController.text = list[i].specialtyTitle;
      }
    }
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

  Future getUserImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedImage.path);
    notifyListeners();
  }

  Future<bool> updateProfile() async {
    if (_image != null) {
      var url = await upLoadImage();
      defaultImage = url.toString();
    }
  }

  void transferToModel() {
    userProfile.fullName = fullNameController.text;
    userProfile.image = defaultImage;

    userProfile.phone = phoneNumController.text;

    userProfile.email = emailController.text;

    userProfile.idCard = identityNumberController.text;

    doctorDetail.degree = degreeController.text;

    doctorDetail.experience = experienceTypeController.text;

    doctorDetail.school = graduatedController.text;
    doctorDetail.description = descriptionController.text;
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
}
