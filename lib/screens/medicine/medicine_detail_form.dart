import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/model/medicine_detail_model.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medicine_detail_form_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class MedicineDetailForm extends StatelessWidget {
  final MedicineDetailModel detailModel;
  MedicineDetailForm({@required this.detailModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicineDetailFormViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: FutureBuilder(
              future: model.initMedicine(detailModel),
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          _buildTopContainer(context, model),
                          _buildBottomContainer(context, model),
                        ],
                      ),
                      _buildAppBar(context, model),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Container _buildBottomContainer(
      BuildContext context, MedicineDetailFormViewModel model) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            _buildTitleCard("Medicine Form", EvaIcons.fileTextOutline,
                Colors.blue, Colors.blue),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  _buildTitle("Total Days"),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 4,
                          child: _buildTotalDaysField(
                              model, model.medicineTotalDays)),
                      Flexible(
                        flex: 6,
                        child: Center(
                          child: Text(
                            "Days",
                            style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTitle("Total Quantity & Type Medicine"),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flexible(flex: 4, child: _buildTotalQuantity(model)),
                      Flexible(flex: 6, child: _buildTypeMedicine(model))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTitle("Morning Quantity"),
                  Row(
                    children: [
                      Flexible(
                          flex: 4,
                          child: _buildQuantityField(
                              model, model.morningQuantityController)),
                      Flexible(flex: 6, child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTitle("Noon Quantity"),
                  Row(
                    children: [
                      Flexible(
                          flex: 4,
                          child: _buildQuantityField(
                              model, model.noonQuantityController)),
                      Flexible(flex: 6, child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTitle("Afternoon Quantity"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 4,
                          child: _buildQuantityField(
                              model, model.afternoonQuantityController)),
                      Flexible(flex: 6, child: Container())
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildTitle("Method"),
                  _buildMethodField(model, model.methodController),
                  SizedBox(
                    height: 20,
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
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _buildMethodField(
      MedicineDetailFormViewModel model, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: controller,
        maxLength: 15,

        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          counterText: "",
          hintText: "How to use this medicine",
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
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }

  Padding _buildQuantityField(
      MedicineDetailFormViewModel model, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        // onChanged: (value) => model.changePhoneNum(value),
        textAlign: TextAlign.center,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "ex: 1,2,3, ...",
          errorText: (model.isValidQuantity)
              ? null
              : (controller.text.isEmpty || int.parse(controller.text) < 1)
                  ? "Please input value"
                  : null,
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
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }

  Padding _buildTotalDaysField(
      MedicineDetailFormViewModel model, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        // onChanged: (value) => model.changePhoneNum(value),
        textAlign: TextAlign.center,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "ex: 1,2,3, ...",
          errorText: (controller.text.isEmpty || int.parse(controller.text) < 1)
              ? "Please input value"
              : null,
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
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }

  Padding _buildTypeMedicine(MedicineDetailFormViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: model.typeController,
        // onChanged: (value) => model.changePhoneNum(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "ex: spoon, pill, ...",
          filled: true,
          errorText: (!model.isValidType) ? "Please Input Valid Value" : null,
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
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }

  Padding _buildChildType(MedicineDetailFormViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        textAlign: TextAlign.center,
        enabled: false,
        controller: model.typeController,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: InputBorder.none,

          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }

  Container _buildTopContainer(
      BuildContext context, MedicineDetailFormViewModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 85),
        child: Column(
          children: [
            _buildTitleCard(
                "Medicine Name", Icons.info, Colors.greenAccent, Colors.white),
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: model.medicineNameController,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
                enabled: false,
                textAlign: TextAlign.center,
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
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

  Padding _buildTitleCard(
      String title, IconData icon, Color color, Color fontColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 45,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.bold,
                color: fontColor,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildAppBar(
      BuildContext context, MedicineDetailFormViewModel model) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(
          'Medicine Detail Form',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              model.addMedicine(context);
            },
            child: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ], //No shadow
      ),
    );
  }

  Padding _buildTotalQuantity(MedicineDetailFormViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        textAlign: TextAlign.center,
        enabled: false,
        controller: model.totalQuantityController,
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(
            color: MainColors.hintTextColor,
          ),
          border: InputBorder.none,

          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          // suffixIcon: model.fullNameController.text.isEmpty
          //     ? null
          //     : InkWell(
          //         onTap: () => model.fullNameController.clear(),
          //         child: Icon(Icons.clear),
          //       ),
        ),
      ),
    );
  }
}
