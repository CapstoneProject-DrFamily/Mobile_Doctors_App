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
import 'package:mobile_doctors_apps/repository/appconfig_repo.dart';
import 'package:mobile_doctors_apps/repository/examination_repo.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class SamplePageViewModel extends BaseModel {
  final IExaminationRepo _examinationRepo = ExaminationRepo();
  final IAppConfigRepo _appConfigRepo = AppConfigRepo();

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

  List<Asset> imagesSerumbiochemistry = List<Asset>();
  List<String> firebaseSerumImage = [];
  bool hasImageSerumbiochemistry = false;
  bool hasInitSerumImage = false;

  List<Asset> imagesUrinebiochemistry = List<Asset>();
  List<String> firebaseUrineImage = [];
  bool hasImageUrinebiochemistry = false;
  bool hasInitUrineImage = false;

  ExaminationHistory _examinationHistory;
  ExaminationHistory get examinationHistory => _examinationHistory;

  DatabaseReference _transactionRequest;

  bool isLoading = false;

  int numberImage;

  fetchData(transactionId, TimeLineViewModel model) async {
    if (init) {
      this.transactionId = transactionId;
      numberImage = await _appConfigRepo.getNumberofImage();
      _examinationHistory =
          await _examinationRepo.getExaminationHistory(transactionId);
      if (model.currentIndex < model.index) {
        _examinationHistory =
            await _examinationRepo.getExaminationHistory(transactionId);
        print("exam $_examinationHistory");
        // imageHematology = _examinationHistory.hematology;
        imageSerumbiochemistry = _examinationHistory.bloodChemistry;
        print("blood $imageSerumbiochemistry");

        if (imageSerumbiochemistry != null) {
          hasInitSerumImage = true;
          List slitSerumImage = imageSerumbiochemistry.split("]");

          for (int i = 0; i < slitSerumImage.length - 1; i++) {
            firebaseSerumImage.add(slitSerumImage[i]);
          }
        }
        imageUrinebiochemistry = _examinationHistory.urineBiochemistry;
        print("urin $imageUrinebiochemistry");
        if (imageUrinebiochemistry != null) {
          hasInitUrineImage = true;
          List slitUrineImage = imageUrinebiochemistry.split("]");

          for (int i = 0; i < slitUrineImage.length - 1; i++) {
            firebaseUrineImage.add(slitUrineImage[i]);
          }
        }
        // imageAbdominalultrasound = _examinationHistory.abdominalUltrasound;
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

  // Future getImageFromGallery(String field) async {
  //   isLoading = true;
  //   notifyListeners();
  //   switch (field) {
  //     case "Hematology":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.gallery);
  //       imageHematologyFile = File(pickedImage.path);
  //       imageHematology = await upLoadImage(imageHematologyFile);
  //       print(imageHematology);
  //       isLoading = false;
  //       notifyListeners();

  //       break;
  //     case "Serum biochemistry":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.gallery);
  //       imageSerumbiochemistryFile = File(pickedImage.path);
  //       imageSerumbiochemistry = await upLoadImage(imageSerumbiochemistryFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Urine biochemistry":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.gallery);
  //       imageUrinebiochemistryFile = File(pickedImage.path);
  //       imageUrinebiochemistry = await upLoadImage(imageUrinebiochemistryFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Abdominal ultrasound":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.gallery);
  //       imageAbdominalultrasoundFile = File(pickedImage.path);
  //       imageAbdominalultrasound =
  //           await upLoadImage(imageAbdominalultrasoundFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     default:
  //   }

  //   notifyListeners();
  // }

  // Future getImageFromCamera(String field) async {
  //   isLoading = true;
  //   notifyListeners();
  //   switch (field) {
  //     case "Hematology":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.camera);
  //       imageHematologyFile = File(pickedImage.path);
  //       imageHematology = await upLoadImage(imageHematologyFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Serum biochemistry":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.camera);
  //       imageSerumbiochemistryFile = File(pickedImage.path);
  //       imageSerumbiochemistry = await upLoadImage(imageSerumbiochemistryFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Urine biochemistry":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.camera);
  //       imageUrinebiochemistryFile = File(pickedImage.path);
  //       imageUrinebiochemistry = await upLoadImage(imageUrinebiochemistryFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Abdominal ultrasound":
  //       var pickedImage =
  //           await ImagePicker().getImage(source: ImageSource.camera);
  //       imageAbdominalultrasoundFile = File(pickedImage.path);
  //       imageAbdominalultrasound =
  //           await upLoadImage(imageAbdominalultrasoundFile);
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     default:
  //   }

  //   notifyListeners();
  // }

  // Future deleteImage(String field) async {
  //   isLoading = true;
  //   notifyListeners();
  //   switch (field) {
  //     case "Hematology":
  //       imageHematology = null;
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Serum biochemistry":
  //       imageSerumbiochemistry = null;
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Urine biochemistry":
  //       imageUrinebiochemistry = null;
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     case "Abdominal ultrasound":
  //       imageAbdominalultrasound = null;
  //       isLoading = false;
  //       notifyListeners();
  //       break;
  //     default:
  //   }

  //   notifyListeners();
  // }

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
    String imageSerum;
    if (imagesSerumbiochemistry.isNotEmpty) {
      List<File> fileSerum = [];
      for (var item in imagesSerumbiochemistry) {
        File file = await getImageFileFromAssets(item);
        fileSerum.add(file);
      }
      imageSerum = "";
      try {
        for (var item in fileSerum) {
          imageSerum = imageSerum + await upLoadImage(item) + "]";
        }
      } catch (e) {
        print(e);
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
    String imageUrin;

    if (imagesUrinebiochemistry.isNotEmpty) {
      List<File> fileUrin = [];
      for (var item in imagesUrinebiochemistry) {
        File file = await getImageFileFromAssets(item);
        fileUrin.add(file);
      }
      imageUrin = "";
      try {
        for (var item in fileUrin) {
          imageUrin = imageUrin + await upLoadImage(item) + "]";
        }
      } catch (e) {
        print(e);
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

    // List slitImage = imageSerum.split("]");
    // for (var item in slitImage) {
    //   print("URL image $item");
    // }

    // if (imageHematology != null) {
    //   _examinationHistory.hematology = imageHematology;
    // }
    print("isNull $imageSerum");
    if (imageSerum != null) {
      _examinationHistory.bloodChemistry = imageSerum;
    } else {
      _examinationHistory.bloodChemistry = imageSerumbiochemistry;
    }
    if (imageUrin != null) {
      _examinationHistory.urineBiochemistry = imageUrin;
    } else {
      _examinationHistory.urineBiochemistry = imageUrinebiochemistry;
    }
    // if (imageAbdominalultrasound != null) {
    //   _examinationHistory.abdominalUltrasound = imageAbdominalultrasound;
    // }

    // isLoading = false;
    // notifyListeners();

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

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File('${(await getTemporaryDirectory()).path}/${asset.name}');
    final file = await tempFile.writeAsBytes(byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    ));

    return file;
  }

  Future<void> pickImagesSerum() async {
    List<Object> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: numberImage,
        enableCamera: true,
        selectedAssets: imagesSerumbiochemistry,
        materialOptions: MaterialOptions(
          actionBarTitle: "Choose Your Image",
        ),
      );
    } on Exception catch (e) {
      print(e);
      hasImageSerumbiochemistry = false;
    }

    imagesSerumbiochemistry = resultList;

    if (imagesSerumbiochemistry.length > 0) {
      hasImageSerumbiochemistry = true;
    }

    print("oke");
    notifyListeners();
  }

  void removeImageSerum(Asset asset) {
    imagesSerumbiochemistry.remove(asset);
    print("Length ${imagesSerumbiochemistry.length}");
    notifyListeners();
  }

  void changeStateHasNoSerum() {
    if (imagesSerumbiochemistry.length == 0) {
      hasImageSerumbiochemistry = false;
      notifyListeners();
    }
  }

  Future<void> pickImagesUrin() async {
    List<Object> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: numberImage,
        enableCamera: true,
        selectedAssets: imagesUrinebiochemistry,
        materialOptions: MaterialOptions(
          actionBarTitle: "Choose Your Image",
        ),
      );
    } on Exception catch (e) {
      print(e);
      hasImageUrinebiochemistry = false;
    }

    imagesUrinebiochemistry = resultList;

    if (imagesUrinebiochemistry.length > 0) {
      hasImageUrinebiochemistry = true;
    }

    print("oke");
    notifyListeners();
  }

  void removeImageUrin(Asset asset) {
    imagesUrinebiochemistry.remove(asset);
    print("Length ${imagesUrinebiochemistry.length}");
    notifyListeners();
  }

  void changeStateHasNoUrin() {
    if (imagesUrinebiochemistry.length == 0) {
      hasImageUrinebiochemistry = false;
      notifyListeners();
    }
  }
}
