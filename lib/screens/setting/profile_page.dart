import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/profile_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<ProfilePageViewModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildImageSelectField(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleCard('Basic Infomation', Icons.info,
                                Colors.greenAccent),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('Full Name'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildFullNameField(model),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('Gender'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildFieldGender(model),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('Date of Birth'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildDOBFIeld(context, model),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('Phone Number'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildPhoneNumberField(model),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('Email'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildEmailField(model),
                            SizedBox(
                              height: 15,
                            ),
                            _buildTitle('ID Card'),
                            SizedBox(
                              height: 5,
                            ),
                            _buildIDCardField(model),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //additional
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleCard('Additional Infomation',
                                EvaIcons.fileTextOutline, Colors.blue),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(child: _buildTitle('Degree')),
                                InkWell(
                                  onTap: () {
                                    model.addListDegrees();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            _buildDegreeTypeField(model, context),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.degrees.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                // controller: model.emailController,
                                                // onChanged: (value) => model.changePhoneNum(value),
                                                style: GoogleFonts.varelaRound(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                    color: MainColors
                                                        .hintTextColor,
                                                  ),
                                                  hintText: "Enter your degree",
                                                  filled: true,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 15),
                                                  suffixIcon: model
                                                          .emailController
                                                          .text
                                                          .isEmpty
                                                      ? null
                                                      : InkWell(
                                                          onTap: () => model
                                                              .emailController
                                                              .clear(),
                                                          child:
                                                              Icon(Icons.clear),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              model.removeDegrees(index);
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                _buildAppbar(context),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildSaveButtom(),
    );
  }

  Padding _buildDegreeTypeField(
      ProfilePageViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        // controller: model.emailController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your degree",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: model.emailController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.emailController.clear(),
                  child: Icon(Icons.clear),
                ),
        ),
      ),
    );
  }

  Padding _buildIDCardField(ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: model.identityNumberController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your ID Card",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: model.identityNumberController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.identityNumberController.clear(),
                  child: Icon(Icons.clear),
                ),
        ),
      ),
    );
  }

  Padding _buildEmailField(ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: model.emailController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your email address",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: model.emailController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.emailController.clear(),
                  child: Icon(Icons.clear),
                ),
        ),
      ),
    );
  }

  Padding _buildPhoneNumberField(ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: model.phoneNumController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter your phone number",
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: model.phoneNumController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.phoneNumController.clear(),
                  child: Icon(Icons.clear),
                ),
        ),
      ),
    );
  }

  Padding _buildDOBFIeld(BuildContext context, ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1900, 1, 1),
              maxTime: DateTime(2099, 12, 31),
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
          // onChanged: (value) => model.changePhoneNum(value),
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
            hintText: "Choose Your Birthday",
            filled: true,
            enabled: false,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            suffixIcon: Icon(
              EvaIcons.calendar,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildFullNameField(ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: model.fullNameController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "Enter your full name",
          filled: true,
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          suffixIcon: model.fullNameController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.fullNameController.clear(),
                  child: Icon(Icons.clear),
                ),
        ),
      ),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      ),
    );
  }

  Row _buildTitleCard(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 45,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildFieldGender(ProfilePageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            model.changeGender(0);
          },
          child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                model.gender == 0
                    ? Icon(
                        EvaIcons.radioButtonOn,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Icon(
                        EvaIcons.radioButtonOffOutline,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Male',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            model.changeGender(1);
          },
          child: Container(
            child: Row(
              children: [
                model.gender == 1
                    ? Icon(
                        EvaIcons.radioButtonOn,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Icon(
                        EvaIcons.radioButtonOffOutline,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Female',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            model.changeGender(2);
          },
          child: Container(
            child: Row(
              children: [
                model.gender == 2
                    ? Icon(
                        EvaIcons.radioButtonOn,
                        color: Colors.blue,
                        size: 25,
                      )
                    : Icon(
                        EvaIcons.radioButtonOffOutline,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Other',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Positioned _buildAppbar(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(
          'Your Profile',
          style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true, // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
    );
  }

  ClipPath _buildImageSelectField() {
    return ClipPath(
      clipper: MyClipper(),
      child: GestureDetector(
        onTap: () {
          print('Select Image');
        },
        child: Container(
          padding: EdgeInsets.only(top: 50, bottom: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.lightBlue[200], Colors.blue[600]]),
            image: DecorationImage(
              image: AssetImage('assets/images/virus.png'),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: SizedBox(
                    width: 95,
                    height: 95,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgG6EKIxYXUZheCOWbsXznT-Bt7t2rz-1txw&usqp=CAU',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSaveButtom() {
    return GestureDetector(
      onTap: () {
        print('save');
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue[400],
          ),
          child: Center(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
