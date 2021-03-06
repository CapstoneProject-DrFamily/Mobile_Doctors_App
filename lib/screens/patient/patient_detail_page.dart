import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_detail_view_model.dart';
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
                      image: AssetImage('assets/patientdetail.jpg'),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // color: MainColors.blueBegin.withOpacity(0.6),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      'Phan Lý Kim Chi Ngọc Diệp',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: SvgPicture.asset(
                                          'assets/icons/male.svg',
                                          width: 40,
                                          height: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
                                    Text('01/01/1999')
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
                                    Text('0988123123')
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
                                    Text('120 cm')
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
                                    Text('50 kg')
                                  ],
                                ),
                              ),
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
  }
}
