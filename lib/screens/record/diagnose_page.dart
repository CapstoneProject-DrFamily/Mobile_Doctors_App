import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/diagnose_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class DiagnosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<DiagnosePageViewModel>(
      builder: (context, child, model) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundhome.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: MainColors.blueBegin.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    width: size.width,
                    height: size.height * 0.82,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            width: size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '1. Bệnh sử',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.white.withOpacity(0.8),
                                        alignment: Alignment.topCenter,
                                        width: size.width * 0.8,
                                        child: TextField(
                                          maxLines: 5,
                                          decoration: InputDecoration.collapsed(
                                              hintText: 'Enter your text'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: size.width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '2. Thăm khám lâm sàng',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '2.1 ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Dấu hiệu sinh tồn, chỉ số nhân trắc học',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Expanded(
                                          child: Text(
                                        'Mạch',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'nhịp/phút'),
                                      )),
                                      Expanded(
                                          child: Text(
                                        'Nhiệt độ',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'độ C'),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Expanded(
                                          child: Text(
                                        'HA',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'),
                                      )),
                                      Expanded(
                                          child: Text(
                                        'Nhịp thở',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Expanded(
                                          child: Text(
                                        'Cân nặng',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'kg'),
                                      )),
                                      Expanded(
                                          child: Text(
                                        'Chiều cao',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'cm'),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Expanded(
                                          child: Text(
                                        'BMI',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'),
                                      )),
                                      Expanded(
                                          child: Text(
                                        'Vòng bụng',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                      Expanded(
                                          child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '...'),
                                      ))
                                    ],
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: MainColors.blueBegin,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '2.2 ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Thị lực',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Không kính ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Mắt trái',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0 ~ 10'),
                                            )),
                                            Expanded(
                                              child: Text(
                                                'Mắt phải',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0 ~ 10'),
                                            )),
                                          ],
                                        ),
                                        Text(
                                          'Có kính',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Mắt trái',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0 ~ 10'),
                                            )),
                                            Expanded(
                                              child: Text(
                                                'Mắt phải',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '0 ~ 10'),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: MainColors.blueBegin,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '2.3 ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Khám lâm sàng',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '2.3.1 ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Toàn thân',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Da, niêm mạc',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: 'Enter text',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Khác',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: 'Enter text',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '2.3.2 ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Cơ quan',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: List.generate(
                                        model.listSpeciality.length, (index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        model
                                                            .listSpeciality[
                                                                index]
                                                            .name,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              child: Checkbox(
                                                value: model.listCheck.contains(
                                                        model
                                                            .listSpeciality[
                                                                index]
                                                            .name)
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  model.changeCheck(
                                                      model
                                                          .listSpeciality[index]
                                                          .name,
                                                      value);
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -66,
                    child: CircleAvatar(
                      radius: 73,
                      backgroundColor: MainColors.blueBegin.withOpacity(0.5),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70,
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/medical-file.svg',
                            height: 80,
                            width: 80,
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
}
