import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/helper/app_image.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/popup_info_patient_page.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class PatientDialog {
  void showCustomDialog(BuildContext context, int patientId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BaseView<PopupInfoPatientPage>(
          builder: (context, child, popupModel) {
            return FutureBuilder(
              future: popupModel.initInfoPatient(patientId),
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: (popupModel.isLoadingPopUp)
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  image: AssetImage('assets/patientdetail.jpg'),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fitWidth),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // color: MainColors.blueBegin.withOpacity(0.6),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50),
                                      bottom: Radius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 30, left: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 32,
                                              backgroundColor: MainColors
                                                  .blueBegin
                                                  .withOpacity(0.6),
                                              child: CircleAvatar(
                                                backgroundImage: (popupModel
                                                            .patientModel
                                                            .patientImage ==
                                                        null)
                                                    ? NetworkImage(DEFAULT_IMG)
                                                    : NetworkImage(
                                                        popupModel.patientModel
                                                            .patientImage,
                                                      ),
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: Text(
                                                          popupModel
                                                              .patientModel
                                                              .patientName,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 5, bottom: 5),
                                                      child: (popupModel
                                                                  .patientModel
                                                                  .patientGender ==
                                                              "Female")
                                                          ? SvgPicture.asset(
                                                              'assets/icons/female.svg',
                                                              width: 20,
                                                              height: 20,
                                                            )
                                                          : SvgPicture.asset(
                                                              'assets/icons/male.svg',
                                                              width: 20,
                                                              height: 20,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                        Text(
                                          'About User',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/dob.svg',
                                                          width: 30,
                                                          height: 30)),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    DateFormat("dd-MM-yyyy")
                                                        .format(
                                                      DateTime.parse(popupModel
                                                          .patientModel
                                                          .patientDOB),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/old-typical-phone.svg',
                                                          width: 30,
                                                          height: 30)),
                                                  SizedBox(width: 10),
                                                  Text(popupModel.patientModel
                                                      .patientPhone)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/height.svg',
                                                          width: 30,
                                                          height: 30)),
                                                  SizedBox(width: 10),
                                                  Text(
                                                      '${popupModel.patientModel.patientHeight} cm')
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/weight-scale.svg',
                                                          width: 30,
                                                          height: 30)),
                                                  SizedBox(width: 10),
                                                  Text(
                                                      '${popupModel.patientModel.patientWeight} kg')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: SvgPicture.asset(
                                                          'assets/icons/blood-type-a.svg',
                                                          width: 30,
                                                          height: 40)),
                                                  SizedBox(width: 10),
                                                  (popupModel.patientModel
                                                              .patientBloodType !=
                                                          null)
                                                      ? Text(popupModel
                                                          .patientModel
                                                          .patientBloodType)
                                                      : Text("Not Choose Yet")
                                                ],
                                              ),
                                            ),
                                            // Expanded(
                                            //   child: Row(
                                            //     children: [
                                            //       Container(
                                            //           child: SvgPicture.asset(
                                            //               'assets/icons/users.svg',
                                            //               width: 30,
                                            //               height: 30)),
                                            //       SizedBox(width: 10),
                                            //       Text(model.patientModel
                                            //           .patientRelationShip)
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                      ],
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
          },
        );
      },
    );
  }
}
