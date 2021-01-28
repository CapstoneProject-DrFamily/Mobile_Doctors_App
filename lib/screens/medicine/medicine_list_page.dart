import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_form.dart';
import 'package:mobile_doctors_apps/screens/record/analyze_page.dart';

import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class MedicineListPage extends StatelessWidget {
  int _processIndex = 3;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<MedicineListViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: MainColors.blueBegin),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage('assets/images/medicinelist.jpg'),
                )),
            child: Column(
              children: [
                timelineProcess(context, _processIndex),
                // Container(
                //   child: Image.asset('assets/medicine.png', fit: BoxFit.fill),
                // ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Stack(
                      alignment: Alignment.topCenter,
                      overflow: Overflow.visible,
                      children: [
                        MedicineFormDetail(),
                        Positioned(
                          top: -66,
                          child: CircleAvatar(
                            radius: 73,
                            backgroundColor:
                                MainColors.blueBegin.withOpacity(0.5),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 70,
                              child: Container(
                                child: Image.asset(
                                  'assets/images/time_line_4.png',
                                  width: 120,
                                  // color: Colors.red,
                                ),

                                // SvgPicture.asset(
                                //   'assets/icons/medical-file.svg',
                                //   height: 80,
                                //   width: 80,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => SingleChildScrollView(
                  child: new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    title: Center(child: new Text("Choose Medicine")),
                    content: Container(
                        width: 300, height: 500, child: MedicineForm()),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnalyzePage()));
                          },
                          child: Text('Add')),
                    ],
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/pills.svg',
              height: 30,
              width: 30,
            ),
            backgroundColor: Colors.lightBlue[100],
          ),
        );
      },
    );
  }
}

class MedicineFormDetail extends StatelessWidget {
  const MedicineFormDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: MainColors.blueBegin.withOpacity(0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                'Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              SizedBox(width: 10),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Period',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Paracetamol 15g',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        '15 viên',
                        style: TextStyle(fontSize: 14),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Sáng',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'viên',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Trưa',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '4',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'viên',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Chiều',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        'viên',
                                        style: TextStyle(fontSize: 14),
                                      ))
                                ],
                              ),
                              // SizedBox(height: 10)
                            ],
                          ))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.lightBlue[100],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
