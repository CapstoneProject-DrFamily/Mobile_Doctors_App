import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/medicine/medicine_list_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/diagnose_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class DiagnosePage extends StatelessWidget {
  int _processIndex = 2;
  @override
  Widget build(BuildContext context) {
    return BaseView<DiagnosePageViewModel>(builder: (context, child, model) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('assets/images/result.jpg'),
              )),
          child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: MainColors.blueBegin),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      timelineProcess(context, _processIndex),
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: MainColors.blueBegin.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 65,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Diagnose / Conclusion',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: model
                                                    .diagnoseConclusionController,
                                                maxLines: 5,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText:
                                                            'Enter your text'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Doctor Advice',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: model
                                                    .doctorAdviceController,
                                                maxLines: 5,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText:
                                                            'Enter your text'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !model.keyboard ? true : false,
                              child: Positioned(
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
                                        'assets/images/time_line_3.png',
                                        width: 120,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !model.keyboard ? true : false,
                              child: Positioned(
                                  bottom: 10,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          color: MainColors.blueBegin
                                              .withOpacity(0.8),
                                          onPressed: () async {
                                            await model.confirmDiagnose();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MedicineListPage()));
                                          },
                                          child: Text('Next')),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )));
    });
  }
}
