import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/helper/app_image.dart';
import 'package:mobile_doctors_apps/helper/common.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_base_transaction_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_detail_view_model.dart';

class PatientTransactionDetailScreen extends StatelessWidget {
  final TransactionBaseViewModel model;
  PatientTransactionDetailScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return BaseView<PatientTransactionDetailViewModel>(
        builder: (context, child, model) {
      return Scaffold(body: FutureBuilder(builder: (contextC, snapshop) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Doctor',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            NetworkImage(this.model.profileDoctor.image),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.model.profileDoctor.fullName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.phone,
                            //       color: Colors.black,
                            //       size: 24.0,
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(this.model.profileDoctor.phone),
                            //   ],
                            // ),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 60,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Chip(
                                            label: Text(
                                                this.model.doctorSpeciality),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Patient',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                            (this.model.profilePatient.image == null)
                                ? NetworkImage(DEFAULT_IMG)
                                : NetworkImage(this.model.profilePatient.image),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.model.profilePatient.fullName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.phone,
                            //       color: Colors.black,
                            //       size: 24.0,
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     Text(this.model.profilePatient.phone),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Service Info',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name'),
                            Text(this.model.service.serviceName)
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price'),
                            Text(Common.convertPrice(
                                this.model.service.servicePrice))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Note',
                        style: TextStyle(
                          color: Color(0xff0d47a1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(this.model.patientTransaction.note == "Nothing"
                          ? ""
                          : this.model.patientTransaction.note),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }));
    });
  }
}
