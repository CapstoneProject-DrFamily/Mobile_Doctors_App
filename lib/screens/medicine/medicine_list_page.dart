import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_list_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class MedicineListPage extends StatelessWidget {
  final TimeLineViewModel timelineModel;
  final String transactionId;

  MedicineListPage(
      {@required this.timelineModel, @required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineListViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
            future: model.fetchData(transactionId),
            builder: (context, snapshot) {
              model.keyboard = MediaQuery.of(context).viewInsets.bottom != 0;
              if (model.init) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else
                return Scaffold(
                  // resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image:
                                  AssetImage('assets/images/medicinelist.jpg'),
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
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
                                          backgroundColor: MainColors.blueBegin
                                              .withOpacity(0.5),
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
                                    Visibility(
                                      visible: !model.keyboard ? true : false,
                                      child: Positioned(
                                          bottom: 10,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  color: MainColors.blueBegin
                                                      .withOpacity(0.8),
                                                  onPressed: () async {
                                                    model.finishTransaction(
                                                      context,
                                                    );
                                                  },
                                                  child: model.isLoading
                                                      ? Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child:
                                                                CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )
                                                      : Text(
                                                          'Finish',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                            ),
                                          )),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
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
            });
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
      child: Padding(
        padding: !model.keyboard
            ? EdgeInsets.only(top: 60.0)
            : EdgeInsets.only(top: 2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              (model.template == null)
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButton(
                        underline: SizedBox(),
                        value: model.template,
                        items: model.listDropdownMenuItems,
                        isExpanded: true,
                        onChanged: (value) {
                          model.onChangeButtom(
                              value, model.listTemplateDisplay.indexOf(value));
                        },
                      ),
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
                        physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Type',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  SizedBox(width: 5),
                                  Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          'Period',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
                                  itemCount:
                                      MedicineListViewModel.listMedicine == null
                                          ? 0
                                          : MedicineListViewModel
                                              .listMedicine.length,
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
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Slidable(
                                            actionPane:
                                                SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.25,
                                            secondaryActions: [
                                              IconSlideAction(
                                                caption: 'Delete',
                                                color: Colors.red,
                                                icon: Icons.delete,
                                                onTap: () async {
                                                  // //Delete transaction
                                                  model.deleteMedicine(
                                                      MedicineListViewModel
                                                          .listMedicine[index]
                                                          .medicineId);
                                                },
                                              ),
                                            ],
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                  width: 30,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  MedicineListViewModel
                                                      .listMedicine[index]
                                                      .totalQuantity
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )),
                                                SizedBox(width: 20),
                                                Expanded(
                                                    child: Text(
                                                  MedicineListViewModel
                                                      .listMedicine[index]
                                                      .medicineType,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                )),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 5,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/sunrise.svg',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
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
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  Container(),
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
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/sun.svg',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
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
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  Container(),
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
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 3,
                                                                        left: 3,
                                                                        right:
                                                                            3,
                                                                        bottom:
                                                                            10),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/moon.svg',
                                                                  width: 15,
                                                                  height: 15,
                                                                ),
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
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  Container(),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.lightBlue[100],
                                        ),
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
      ),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Padding _buildNoteField(MedicineListViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15),
      child: TextFormField(
        controller: model.notecontroller,
        keyboardType: TextInputType.multiline,
        maxLength: 255,
        maxLines: 4,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),

        decoration: InputDecoration(
          hintText: "Write some note for patient!",
          filled: true,
          counterText: "",
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
