import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/profile_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: model.loadingProfile
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildImageSelectField(model),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildTitleCard('Basic Infomation',
                                      Icons.info, Colors.greenAccent),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Full Name'),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildFullNameField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Gender'),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildFieldGender(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Date of Birth'),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildDOBFIeld(context, model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Phone Number'),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildPhoneNumberField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Email'),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildEmailField(model),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Social Security Number'),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
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
                                      Expanded(
                                        child: Row(
                                          children: [
                                            _buildTitle('Degree'),
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  _buildDegreeTypeField(model, context),
                                  buildListViewDegree(model),
                                  Row(
                                    children: [
                                      _buildTitle('Speciality'),
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _buildSpecialityTypeField(model, context),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Experience'),
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  buildTextFieldForm(
                                      model,
                                      model.experienceTypeController,
                                      "Enter your experience"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('School'),
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  buildTextFieldForm(
                                      model,
                                      model.graduatedController,
                                      "Enter your graduated university"),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      _buildTitle('Extra infomation'),
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
                                  buildDescriptionForm(model),
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
                ),
          bottomNavigationBar: _buildSaveButtom(model, context),
        );
      },
    );
  }

  Padding buildDescriptionForm(ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: model.descriptionController,
        maxLines: 5,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: "Enter extra information",
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
        ),
      ),
    );
  }

  Padding buildTextFieldForm(ProfilePageViewModel model,
      TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        maxLines: 2,
        keyboardType: TextInputType.number,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          hintText: hintText,
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        ),
      ),
    );
  }

  ListView buildListViewDegree(ProfilePageViewModel model) {
    return ListView.builder(
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
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TextFormField(
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          // suffixIcon: model
                          //         .specialityTpeController
                          //         .text
                          //         .isEmpty
                          //     ? null
                          //     : InkWell(
                          //         onTap: () => model
                          //             .specialityTpeController
                          //             .clear(),
                          //         child:
                          //             Icon(Icons.clear),
                          //       ),
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
        });
  }

  Padding _buildDegreeTypeField(
      ProfilePageViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        readOnly: true,
        controller: model.degreeController,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
        readOnly: true,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.blue,
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
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        readOnly: true,
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Padding _buildDOBFIeld(BuildContext context, ProfilePageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: model.dobController,
        readOnly: true,
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          prefixIcon: Icon(
            EvaIcons.calendar,
            color: Colors.blue,
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
        readOnly: true,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
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
          fillColor: Colors.grey.shade100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
          // onTap: () {
          //   model.changeGender(1);
          // },
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
                        color: Colors.grey.shade300,
                        size: 25,
                      ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Female',
                  style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey.shade300),
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

  ClipPath _buildImageSelectField(ProfilePageViewModel model) {
    return ClipPath(
      clipper: MyClipper(),
      child: GestureDetector(
        onTap: () {
          model.getUserImage();
        },
        child: Container(
          padding: EdgeInsets.only(top: 70, bottom: 50),
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
                backgroundColor: Colors.blue,
                backgroundImage: (model.image != null
                    ? FileImage(model.image)
                    : NetworkImage(model.currentImage)),
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
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSaveButtom(
      ProfilePageViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool isUpdated = await model.updateProfile();
        print(isUpdated);
        if (isUpdated) {
          Fluttertoast.showToast(
            msg: "Update Successfull",
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            gravity: ToastGravity.CENTER,
          );
        }
      },
      child: model.loadingProfile
          ? Text('')
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue[400],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: model.isLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Container(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding _buildSpecialityTypeField(
      ProfilePageViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        child: TextFormField(
          controller: model.specialityTpeController,
          readOnly: true,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: "Choose Your Speciality",
            filled: true,
            enabled: false,
            hintStyle: TextStyle(
              color: MainColors.hintTextColor,
            ),
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
            fillColor: Colors.grey.shade100,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
