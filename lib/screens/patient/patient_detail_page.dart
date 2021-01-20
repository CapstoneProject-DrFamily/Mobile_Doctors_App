import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_detail_viewmodel.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class PatientDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PatientDetailPageViewModel>(
        builder: (context, child, model) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundhome.jpg'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth)),
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: MainColors.blueBegin.withOpacity(0.6),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(80))),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor:
                                MainColors.blueBegin.withOpacity(0.6),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://gocsuckhoe.com/wp-content/uploads/2020/09/avatar-facebook.jpg',
                              ),
                              radius: 50,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
