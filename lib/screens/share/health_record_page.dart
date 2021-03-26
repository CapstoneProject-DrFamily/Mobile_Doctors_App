import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/health_record_page_view_model.dart';

class HealthRecordScreen extends StatelessWidget {
  final int patientId;
  final String patientName;
  HealthRecordScreen(
      {Key key, @required this.patientId, @required this.patientName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HealthRecordViewModel>(builder: (context, child, model) {
      return FutureBuilder(
        future: model.getHealthRecordByID(patientId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: new AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "$patientName Health Record",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0d47a1),
                    ),
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios,
                        color: Color(0xff0d47a1)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff0d47a1),
                    tabs: [
                      Tab(
                        child: Text(
                          "History & Allergy",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Exposure",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _tabView1(context, model),
                    _tabView2(context, model),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      );
    });
  }

  //TabBarView for Tiền sử & Dị ứng
  DefaultTabController _tabView1(
      BuildContext context, HealthRecordViewModel model) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0.0,
          title: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff0d47a1),
            ),
            tabs: [
              //Tab Tình trạng lúc sinh
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Condition at birth",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sự bệnh tật, dị ứng
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 180,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "History, Allergy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab khuyết tật
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Disabilities",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sử phẩu thuật
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Surgical biography",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab tiền sử gia đình
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 140,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Family history",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Tab vấn đề khác
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Color(0xff0d47a1),
                      width: 1,
                    ),
                  ),
                  child: SizedBox(
                    width: 120,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _tabView3(context, model),
            _tabView4(context, model),
            _tabView5(context, model),
            _tabView6(context, model),
            _tabView7(context, model),
            _tabView8(context, model),
          ],
        ),
      ),
    );
  }

  //TabBarView for Yếu tố tiếp xúc
  Widget _tabView2(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Smoking cigarettes, waterpipe",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(
                    right: 40.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceCigarette == 0
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No',
                        style: (model.choiceCigarette == 0)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      model.choiceCigarette == 1
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Yes',
                        style: (model.choiceCigarette == 1)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.only(
                    right: 40.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceCigarette == 2
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Smoke often',
                        style: (model.choiceCigarette == 2)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      model.choiceCigarette == 3
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Quit',
                        style: (model.choiceCigarette == 3)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Drink alcohol regularly",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      left: 14.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceWine == 0
                            ? Icon(
                                EvaIcons.radioButtonOn,
                                color: Colors.blue,
                                size: 25,
                              )
                            : Icon(
                                EvaIcons.radioButtonOffOutline,
                                color: Colors.grey,
                                size: 25,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Yes',
                          style: (model.choiceWine == 0)
                              ? GoogleFonts.varelaRound(
                                  fontWeight: FontWeight.bold, fontSize: 16)
                              : GoogleFonts.varelaRound(
                                  color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      left: 14.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceWine == 1
                            ? Icon(
                                EvaIcons.radioButtonOn,
                                color: Colors.blue,
                                size: 25,
                              )
                            : Icon(
                                EvaIcons.radioButtonOffOutline,
                                color: Colors.grey,
                                size: 25,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'No',
                          style: (model.choiceWine == 1)
                              ? GoogleFonts.varelaRound(
                                  fontWeight: FontWeight.bold, fontSize: 16)
                              : GoogleFonts.varelaRound(
                                  color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.only(left: 8),
                    margin: EdgeInsets.only(
                      left: 14.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: [
                        model.choiceWine == 2
                            ? Icon(
                                EvaIcons.radioButtonOn,
                                color: Colors.blue,
                                size: 25,
                              )
                            : Icon(
                                EvaIcons.radioButtonOffOutline,
                                color: Colors.grey,
                                size: 25,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Quit',
                          style: (model.choiceWine == 2)
                              ? GoogleFonts.varelaRound(
                                  fontWeight: FontWeight.bold, fontSize: 16)
                              : GoogleFonts.varelaRound(
                                  color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Drug use",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(
                    right: 40.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceDrug == 0
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No',
                        style: (model.choiceDrug == 0)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      model.choiceDrug == 1
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Yes',
                        style: (model.choiceDrug == 1)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceDrug == 2
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Usually use',
                        style: (model.choiceDrug == 2)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      model.choiceDrug == 3
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Quit',
                        style: (model.choiceDrug == 3)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                bottom: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Physical activity",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(
                    right: 40.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceActivity == 0
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No',
                        style: (model.choiceActivity == 0)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      model.choiceActivity == 1
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Yes',
                        style: (model.choiceActivity == 1)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: EdgeInsets.only(left: 8),
                  margin: EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: Row(
                    children: [
                      model.choiceActivity == 2
                          ? Icon(
                              EvaIcons.radioButtonOn,
                              color: Colors.blue,
                              size: 25,
                            )
                          : Icon(
                              EvaIcons.radioButtonOffOutline,
                              color: Colors.grey,
                              size: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Regularly',
                        style: (model.choiceActivity == 2)
                            ? GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold, fontSize: 16)
                            : GoogleFonts.varelaRound(
                                color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Occupational exposure factors / Habitat (chemiscals, dust, noise, viruses,..)",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Indicatie the exposure element",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.exposureElementController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Contact time",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.contactTimeController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Type of household toilet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.toiletTypeController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15.0,
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20.0),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Other risk",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other risk",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.otherRisksController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tình trạng lúc sinh
  Widget _tabView3(BuildContext context, HealthRecordViewModel model) {
    List<String> buttonOriginalList = [
      "Spontaneous delivery",
      "Abdominal delivery",
      "Premature labour",
      "Suffocation"
    ];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Condition at birth",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.9,
                minHeight: 40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xff0d47a1)),
              ),
              child: Text(
                model.conditionAtBirth != ""
                    ? model.conditionAtBirth
                    : "Spontaneous delivery",
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 60),
                          child: Column(
                            children: [
                              Text(
                                "Birth weight",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            "Baby length",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 80.0,
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: model.birthWeightController,
                          keyboardType: TextInputType.text,
                          enabled: false,
                          maxLength: 3,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          initialValue: 'kg',
                          enabled: false,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100.0,
                      ),
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          controller: model.birthHeightController,
                          keyboardType: TextInputType.text,
                          maxLength: 3,
                          enabled: false,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: TextFormField(
                          initialValue: 'cm',
                          enabled: false,
                          decoration: InputDecoration(
                            filled: false,
                            contentPadding: new EdgeInsets.symmetric(
                              vertical: 14.2,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Congenital Disorder (describe if any)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.825,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: TextField(
                            enabled: false,
                            controller: model.birthDefectsController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Nothing',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Other",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.825,
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: TextField(
                            controller: model.otherDefectsController,
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0.01),
                              border: InputBorder.none,
                              hintText: 'Nothing',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử bệnh tật, dị ứng
  Widget _tabView4(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "History, Allergy",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Allergy",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Medicines allergy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.medicineAllergyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Comestic Allergy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.chemicalAllergyController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Food Allergies",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.foodAllergyController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other Allergies",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherAllergyController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pathology",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pathology",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.diseaseController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.cancerController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tuberculosis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.tuberculosisController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      controller: model.otherDiseasesController,
                      enabled: false,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for khuyết tật
  Widget _tabView5(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Disabilities",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hearing",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.hearingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Eyesight",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.eyesightController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hand",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.handController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Leg",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.legController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Scoliosis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.scoliosisController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cleft palate",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.cleftLipController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.otherDisabilitiesController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử phẫu thuật
  Widget _tabView6(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Surgical biography",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 6,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Describe the anatomical part of the body and the year of surgery",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.surgeryHistoryController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Tiền sử gia đình
  Widget _tabView7(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Family history",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Allergy",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Medicines allergy - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.medicineAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Comestic allergy - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.chemicalAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Food allergies - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.foodAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other allergy - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.otherAllergyFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pathology",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Pathology - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.diseaseFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Cancer - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.cancerFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Tuberculosis - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.tuberculosisFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 8,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Other - patient",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.otherDiseasesFamilyController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

//TabBarView for Vấn đề khác
  Widget _tabView8(BuildContext context, HealthRecordViewModel model) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Other",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width * 0.925,
              height: MediaQuery.of(context).size.height / 6,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Describe (if any)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.825,
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      left: 15.0,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: model.otherController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0.01),
                        border: InputBorder.none,
                        hintText: 'Nothing',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
