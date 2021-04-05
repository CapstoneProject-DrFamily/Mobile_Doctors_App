import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_doctors_apps/enums/processState.dart';
import 'package:mobile_doctors_apps/model/examination_history.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:path/path.dart' as path;

class SamplePageViewModel extends BaseModel {
  final IExaminationRepo _examinationRepo = ExaminationRepo();

  String transactionId;
  bool init = true;

  List<String> listCheck = [];

  String imageHematology;
  String imageSerumbiochemistry;
  String imageUrinebiochemistry;
  String imageAbdominalultrasound;

  File imageHematologyFile;
  File imageSerumbiochemistryFile;
  File imageUrinebiochemistryFile;
  File imageAbdominalultrasoundFile;

  ExaminationHistory _examinationHistory;
  ExaminationHistory get examinationHistory => _examinationHistory;

  DatabaseReference _transactionRequest;

  bool isLoading = false;

  fetchData(transactionId, TimeLineViewModel model) async {
    if (init) {
      this.transactionId = transactionId;
      if (model.currentIndex < model.index) {
        _examinationHistory =
            await _examinationRepo.getExaminationHistory(transactionId);
        imageHematology = _examinationHistory.hematology;
        imageSerumbiochemistry = _examinationHistory.bloodChemistry;
        imageUrinebiochemistry = _examinationHistory.urineBiochemistry;
        imageAbdominalultrasound = _examinationHistory.abdominalUltrasound;
      }

      init = false;
      print("load transaction");
    }
  }

  void changeCheck(String name) {
    if (!listCheck.contains(name)) {
      listCheck.add(name);
    } else {
      listCheck.remove(name);
    }

    notifyListeners();
  }

  Future getImageFromGallery(String field) async {
    switch (field) {
      case "Hematology":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.gallery);
        imageHematologyFile = File(pickedImage.path);
        imageHematology = await upLoadImage(imageHematologyFile);
        print(imageHematology);

        break;
      case "Serum biochemistry":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.gallery);
        imageSerumbiochemistryFile = File(pickedImage.path);
        imageSerumbiochemistry = await upLoadImage(imageSerumbiochemistryFile);

        break;
      case "Urine biochemistry":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.gallery);
        imageUrinebiochemistryFile = File(pickedImage.path);
        imageUrinebiochemistry = await upLoadImage(imageUrinebiochemistryFile);

        break;
      case "Abdominal ultrasound":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.gallery);
        imageAbdominalultrasoundFile = File(pickedImage.path);
        imageAbdominalultrasound =
            await upLoadImage(imageAbdominalultrasoundFile);

        break;
      default:
    }

    notifyListeners();
  }

  Future getImageFromCamera(String field) async {
    switch (field) {
      case "Hematology":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.camera);
        imageHematologyFile = File(pickedImage.path);
        imageHematology = await upLoadImage(imageHematologyFile);

        break;
      case "Serum biochemistry":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.camera);
        imageSerumbiochemistryFile = File(pickedImage.path);
        imageSerumbiochemistry = await upLoadImage(imageSerumbiochemistryFile);

        break;
      case "Urine biochemistry":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.camera);
        imageUrinebiochemistryFile = File(pickedImage.path);
        imageUrinebiochemistry = await upLoadImage(imageUrinebiochemistryFile);

        break;
      case "Abdominal ultrasound":
        var pickedImage =
            await ImagePicker().getImage(source: ImageSource.camera);
        imageAbdominalultrasoundFile = File(pickedImage.path);
        imageAbdominalultrasound =
            await upLoadImage(imageAbdominalultrasoundFile);

        break;
      default:
    }

    notifyListeners();
  }

  Future<String> upLoadImage(File image) async {
    String basename = path.basename(image.path);
    StorageReference reference =
        FirebaseStorage.instance.ref().child("DoctorStorage/" + basename);
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

  void saveSample(BuildContext context, TimeLineViewModel model) async {
    isLoading = true;
    notifyListeners();
    _examinationHistory.hematology = imageHematology;
    _examinationHistory.bloodChemistry = imageSerumbiochemistry;
    _examinationHistory.urineBiochemistry = imageUrinebiochemistry;
    _examinationHistory.abdominalUltrasound = imageAbdominalultrasound;

    String jsonExaminationHistory = jsonEncode(_examinationHistory);

    bool diagnoseStatus =
        await _examinationRepo.updateExaminationHistory(jsonExaminationHistory);
    if (diagnoseStatus) {
      if (model.index == model.currentIndex) {
        _transactionRequest = FirebaseDatabase.instance
            .reference()
            .child("Transaction")
            .child(transactionId);

        await _transactionRequest.update({"transaction_status": "Diagnose"});
        model.index = ProcessState.DIAGNOSE;
      }
      isLoading = false;
      notifyListeners();

      await CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.success,
        text: "Update Record Success",
        backgroundColor: Colors.lightBlue[200],
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
        },
      );
      model.changeIndex(2);
    } else {
      isLoading = false;
      notifyListeners();

      await CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.error,
          text: "Update Record Fail!",
          backgroundColor: Colors.lightBlue[200],
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
          });
    }
  }
}
