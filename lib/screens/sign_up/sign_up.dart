import 'package:commons/commons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/login/login_page.dart';
import 'package:mobile_doctors_apps/screens/view_model/sign_up_view_model.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.blue.shade400,
            title: const Text(
              "Create new account",
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  _imageField(context, model),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30.0, left: 30.0),
                    child: Row(
                      children: [
                        Text(
                          "Basic Infomation",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          "(*)",
                          style: TextStyle(
                            color: Colors.red.shade300,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _nameField(context, model),
                  _idCardField(context, model),
                  _buildListGender(context, model),
                  _dobField(context, model),
                  _emailField(context, model),
                  Container(
                    height: 15.0,
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.only(top: 20.0),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 15.0, left: 30.0),
                    child: Row(
                      children: [
                        Text(
                          "Professional Infomation",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          "(*)",
                          style: TextStyle(
                            color: Colors.red.shade300,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _degreeField(context, model),
                  _experienceField(context, model),
                  _buildListSpecialty(context, model),
                  _schoolField(context, model),
                  _descriptionField(context, model),
                  GestureDetector(
                    onTap: () async {
                      // model.printCheck();
                      bool isConfirm = await _confirmDialog(context);

                      if (isConfirm) {
                        waitDialog(context,
                            message: "Creating your account...");

                        bool check = await model.createNewDoctorAccount();

                        print("Check: " + check.toString());
                        if (check) {
                          Navigator.of(context).pop();

                          await CoolAlert.show(
                            barrierDismissible: false,
                            context: context,
                            type: CoolAlertType.success,
                            text: "Sign Up success",
                            backgroundColor: Colors.lightBlue[200],
                            onConfirmBtnTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            },
                          );
                        } else {
                          Navigator.of(context).pop();

                          await CoolAlert.show(
                              barrierDismissible: false,
                              context: context,
                              type: CoolAlertType.error,
                              text: "Sign Up Fail!",
                              backgroundColor: Colors.lightBlue[200],
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                              });
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        bottom: 15,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (alertContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            height: 380,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.info,
                  color: Color(0xff4ee1c7),
                  size: 90,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Confirm action",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                    color: Color(0xff0d47a1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Text(
                    'Are you sure all your information are correct?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'avenir',
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.of(alertContext).pop(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.of(alertContext).pop(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _imageField(BuildContext context, SignUpViewModel model) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 80.0,
          backgroundImage: (model.image != null
              ? FileImage(model.image)
              : NetworkImage(model.defaultImage)),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade400,
              radius: 20.0,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  size: 18.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  model.getUserImage();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.fullNameController,
        onChanged: (text) {
          model.checkFullName(text);
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Enter fullname',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorText: model.fullName.error,
        ),
      ),
    );
  }

  Widget _idCardField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.idCardController,
        onChanged: (text) {
          model.checkIDCard(text);
        },
        keyboardType: TextInputType.number,
        maxLength: 12,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          labelText: 'Enter Social Security Number',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorText: model.idCard.error,
        ),
      ),
    );
  }

  Widget _buildListGender(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter: PickerDataAdapter<String>(pickerdata: model.genderList),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseGender(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              print("gender: " + model.genderController.text);
              return "Please enter your conclusion";
            }
            return null;
          },
          controller: model.genderController,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            labelText: 'Choose Gender',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorText: model.gender.error,
            errorStyle: TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dobField(BuildContext context, SignUpViewModel model) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.6,
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1961, 1, 1),
              maxTime: DateTime(1997, 12, 31),
              theme: DatePickerTheme(
                  cancelStyle: TextStyle(color: Colors.black, fontSize: 16),
                  itemStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
              onChanged: (date) {
            model.changeDOB(date);
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            model.changeDOB(date);
            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: TextFormField(
          controller: model.dobController,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: 'Choose Your Birthday',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            filled: true,
            enabled: false,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            suffixIcon: Icon(
              EvaIcons.calendar,
              color: Colors.blue,
            ),
            errorText: model.checkDOB.error,
            errorStyle: TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.emailController,
        onChanged: (text) {
          model.checkEmail(text);
        },
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Enter email',
          hintText: 'example@gmail.com',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorText: model.email.error,
        ),
      ),
    );
  }

  Widget _degreeField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter: PickerDataAdapter<String>(pickerdata: model.listDegree),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseDegree(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.degreeController,
          keyboardType: TextInputType.phone,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            labelText: 'Choose Degree',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorText: model.degree.error,
            errorStyle: TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _experienceField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.experienceController,
        onChanged: (text) {
          model.checkExperience(text);
        },
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Enter experience',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorText: model.experience.error,
        ),
      ),
    );
  }

  Widget _descriptionField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 20.0,
      ),
      child: TextFormField(
        controller: model.descriptionController,
        maxLines: 2,
        onChanged: (text) {
          model.checkDescription(text);
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Enter extra information about you',
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorText: model.description.error,
        ),
      ),
    );
  }

  Widget _buildListSpecialty(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter:
                PickerDataAdapter<String>(pickerdata: model.listSpecialtyName),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseSpecialty(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.specialtyController,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            labelText: 'Choose Specialty',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorText: model.specialty.error,
            errorStyle: TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _schoolField(BuildContext context, SignUpViewModel model) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: () {
          Picker(
            adapter: PickerDataAdapter<String>(pickerdata: model.listSchool),
            changeToFirst: false,
            selecteds: [0],
            hideHeader: false,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: Colors.black, fontSize: 22),
            selectedTextStyle: TextStyle(color: Colors.blue),
            columnPadding: const EdgeInsets.all(8.0),
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.adapter.text);
              model.chooseSchool(picker.getSelectedValues().first);
            },
          ).showModal(context);
        },
        child: TextFormField(
          controller: model.schoolController,
          maxLines: 2,
          decoration: InputDecoration(
            filled: true,
            enabled: false,
            fillColor: Colors.white,
            labelText: 'Choose School',
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorText: model.school.error,
            errorStyle: TextStyle(color: Colors.red),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
