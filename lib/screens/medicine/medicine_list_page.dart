import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class MedicineListPage extends StatelessWidget {
  int _processIndex = 3;
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineListViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: MainColors.blueBegin),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: <Widget>[
              FlatButton(
                textColor: Colors.blue,
                onPressed: () {
                  model.finishTransaction(context);
                },
                child: Text(
                  "Finish",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
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
                          MedicineFormDetail(
                            model: model,
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
                                      'assets/images/time_line_4.png',
                                      width: 120,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.addMedicine(context);
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
  final MedicineListViewModel model;
  MedicineFormDetail({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MainColors.blueBegin.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: TabBar(tabs: [
                      Tab(
                        child: Text(
                          "Medicine",
                          style: GoogleFonts.varelaRound(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Prescription Note",
                          style: GoogleFonts.varelaRound(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(width: 10),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        'Period',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: MedicineListViewModel.listMedicine ==
                                        null
                                    ? 0
                                    : MedicineListViewModel.listMedicine.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    model.editMedicine(
                                        context,
                                        MedicineListViewModel
                                            .listMedicine[index]);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 75,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    MedicineListViewModel
                                                        .listMedicine[index]
                                                        .medicineName,
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
                                              MedicineListViewModel
                                                      .listMedicine[index]
                                                      .totalQuantity
                                                      .toString() +
                                                  " " +
                                                  MedicineListViewModel
                                                      .listMedicine[index]
                                                      .medicineType,
                                              style: TextStyle(fontSize: 14),
                                            )),
                                            SizedBox(width: 20),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            'Morning',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Center(
                                                            child: Text(
                                                              MedicineListViewModel
                                                                  .listMedicine[
                                                                      index]
                                                                  .morningQuantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            MedicineListViewModel
                                                                .listMedicine[
                                                                    index]
                                                                .medicineType,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            'Noon',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              MedicineListViewModel
                                                                  .listMedicine[
                                                                      index]
                                                                  .noonQuantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            MedicineListViewModel
                                                                .listMedicine[
                                                                    index]
                                                                .medicineType,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            'Afternoon',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              MedicineListViewModel
                                                                  .listMedicine[
                                                                      index]
                                                                  .afternoonQuantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              MedicineListViewModel
                                                                  .listMedicine[
                                                                      index]
                                                                  .medicineType,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.lightBlue[100],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            _buildTitle("Note"),
                            _buildNoteField(model),
                          ],
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

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _buildNoteField(MedicineListViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15),
      child: TextFormField(
        controller: model.notecontroller,
        keyboardType: TextInputType.multiline,
        maxLength: null,
        maxLines: null,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "Write some note for patient!",
          filled: true,
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
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
}
