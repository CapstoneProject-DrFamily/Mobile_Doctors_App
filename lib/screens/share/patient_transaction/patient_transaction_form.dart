import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_base_transaction_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_form_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class TransactionFormScreen extends StatelessWidget {
  final TransactionBaseViewModel model;
  TransactionFormScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return BaseView<PatientTransactionFormViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildMedicalHistoryExpand(context, this.model),
                  SizedBox(
                    height: 10,
                  ),
                  buildExaminationExpand(context, model),
                  SizedBox(
                    height: 10,
                  ),
                  buildOrganismExpand(context, model),
                  SizedBox(
                    height: 10,
                  ),
                  buildDiagnoseExpand(context),
                  SizedBox(
                    height: 10,
                  ),
                  buildExaminationExperimentExpand(context),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildExaminationExperimentExpand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Examination',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1.Hematology test',
                            style: TextStyle(
                                color: Color(0xff0d47a1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: this.model.listCheck.contains("Hematology")
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: this.model.listCheck.contains("Hematology")
                          ? true
                          : false,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: this.model.listCheck.contains("Hematology")
                            ? Image.network(
                                this.model.examinationForm.hematology,
                                width: 200,
                                height: 250,
                                fit: BoxFit.fill)
                            : Text("No data"),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2.Serum biochemistry',
                            style: TextStyle(
                                color: Color(0xff0d47a1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: this
                                      .model
                                      .listCheck
                                      .contains("Serum biochemistry")
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          this.model.listCheck.contains("Serum biochemistry")
                              ? true
                              : false,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child:
                            this.model.listCheck.contains("Serum biochemistry")
                                ? Image.network(
                                    this.model.examinationForm.bloodChemistry,
                                    width: 200,
                                    height: 250,
                                    fit: BoxFit.fill)
                                : Text("No data"),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '3.Urine biochemistry',
                            style: TextStyle(
                                color: Color(0xff0d47a1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: this
                                      .model
                                      .listCheck
                                      .contains("Urine biochemistry")
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          this.model.listCheck.contains("Urine biochemistry")
                              ? true
                              : false,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: this
                                  .model
                                  .listCheck
                                  .contains("Urine biochemistry")
                              ? Image.network(
                                  this.model.examinationForm.urineBiochemistry,
                                  width: 200,
                                  height: 250,
                                  fit: BoxFit.fill)
                              : Text("No data")),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '4.Abdominal ultrasound',
                            style: TextStyle(
                                color: Color(0xff0d47a1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: this
                                      .model
                                      .listCheck
                                      .contains("Abdominal ultrasound")
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          this.model.listCheck.contains("Abdominal ultrasound")
                              ? true
                              : false,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: this
                                  .model
                                  .listCheck
                                  .contains("Abdominal ultrasound")
                              ? Image.network(
                                  this
                                      .model
                                      .examinationForm
                                      .abdominalUltrasound,
                                  width: 200,
                                  height: 250,
                                  fit: BoxFit.fill)
                              : Text("No data")),
                    ),
                  ],
                ),
              ),
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildDiagnoseExpand(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Diagnose',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Diagnose / Conclusion',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0d47a1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              for (var item in this.model.diagnoseList)
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 5, right: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  // constraints: BoxConstraints(
                                  //   maxWidth:
                                  //       MediaQuery.of(context).size.width * 0.7,
                                  // ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xff0d47a1),
                                  ),
                                  child: Text(
                                    item.trim(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Doctor Advice',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0d47a1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff0d47a1),
                            ),
                            initialValue: this.model.examinationForm.advisory,
                            maxLines: 5,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter your text'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildOrganismExpand(
      BuildContext context, PatientTransactionFormViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Organs',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Column(
                children:
                    List.generate(this.model.listSpeciality.length, (index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    this.model.listSpeciality[index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0d47a1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Checkbox(
                              value: this.model.listCheck.contains(
                                      this.model.listSpeciality[index].name)
                                  ? true
                                  : false,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                  Visibility(
                    visible: this
                        .model
                        .listCheck
                        .contains(this.model.listSpeciality[index].name),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              // height: MediaQuery.of(context).size.height * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: this.model.getTextData(index),
                                  readOnly: true,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      hintText: 'Enter text',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              );
            })),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildExaminationExpand(
      BuildContext context, PatientTransactionFormViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Clinical Diagnosis',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: buildExamination(context, model),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Row buildMedicalHistoryExpand(
      BuildContext context, TransactionBaseViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xff0d47a1),
          ),
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Medical History',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            expanded: buildMedicalHistory(context, model),
            tapHeaderToExpand: true,
            hasIcon: true,
            iconColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Container buildExamination(
      BuildContext context, PatientTransactionFormViewModel model) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                  '2. Clinical Diagnosis',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2.1 ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Vital Signs',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0d47a1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildAnthropometricIndex("Pulse", "BPM", model, "pulseRate"),
              // buildErrorMessage(),
              buildAnthropometricIndex(
                  "Temperature", "Celsius", model, "temperature"),
              buildAnthropometricIndex(
                  "Blood Pressure", "mm/Hg", model, "bloodPressure"),
              buildAnthropometricIndex(
                  "Respiratory Rate", "BRPM", model, "respiratoryRate"),
              buildAnthropometricIndex("Weight", "kg", model, "weight"),
              buildAnthropometricIndex("Height", "cm", model, "height"),
              buildAnthropometricIndex("BMI", "kg/m2", model, "BMI"),
              buildAnthropometricIndex(
                  "Hips", "cm", model, "waistCircumference"),
              Divider(
                thickness: 0.5,
              ),
              buildEyeSight(model),
              Divider(
                thickness: 0.5,
              ),
              buildBody(model),
            ],
          ),
        ),
      ),
    );
  }

  Row buildMedicalHistory(
      BuildContext context, TransactionBaseViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                      '1. Medical History',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0d47a1),
                      ),
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            style: TextStyle(
                              color: Color(0xff0d47a1),
                            ),
                            initialValue: model.examinationForm.history,
                            maxLines: 5,
                            decoration: InputDecoration.collapsed(),
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAnthropometricIndex(String label, String hintText,
      PatientTransactionFormViewModel model, String field) {
    return Row(
      children: [
        SizedBox(width: 15),
        Expanded(
            child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff0d47a1),
          ),
        )),
        Expanded(
          //   child: Container(
          // margin: EdgeInsets.only(right: 10, bottom: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: MainColors.blueBegin.withOpacity(0.6))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: TextFormField(
                initialValue: field == "bloodPressure"
                    ? this.model.examinationForm.bloodPressure != null
                        ? this.model.examinationForm.bloodPressure +
                            " " +
                            hintText
                        : null
                    : this.model.getFieldNumber(field) != null
                        ? this.model.getFieldNumber(field).toStringAsFixed(0) +
                            " " +
                            hintText
                        : null,
                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff0d47a1),
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: MainColors.blueBegin, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: hintText,
                ),
              ),
            ),
          ),
          // )
        ),
      ],
    );
  }

  Column buildEyeSight(PatientTransactionFormViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.2 ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
              ),
              Flexible(
                child: Text(
                  'Eye Sight',
                  style: TextStyle(
                    color: Color(0xff0d47a1),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No glasses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
              ),
              buildEyeExaminationForm("Left Eye", "0 ~ 10", model, "leftEye"),
              buildEyeExaminationForm("Right Eye", "0 ~ 10", model, "rightEye"),
              Text(
                'With glasses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
              ),
              buildEyeExaminationForm(
                  "Left Eye", "0 ~ 10", model, "leftEyeGlassed"),
              buildEyeExaminationForm(
                  "Right Eye", "0 ~ 10", model, "rightEyeGlassed"),
            ],
          ),
        ),
      ],
    );
  }

  Row buildEyeExaminationForm(String label, String hintText,
      PatientTransactionFormViewModel model, String field) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xff0d47a1),
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
            child: TextFormField(
              initialValue: this.model.getFieldNumber(field) != null
                  ? this.model.getFieldNumber(field).toString()
                  : null,
              enabled: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: MainColors.blueBegin, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: hintText,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Column buildBody(PatientTransactionFormViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                '2.3 ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
              ),
              Flexible(
                child: Text(
                  'Paraclinical',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              Text(
                '2.3.1 ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d47a1),
                ),
              ),
              Flexible(
                child: Text(
                  'Full body',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0d47a1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Mucosocutaneous',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff0d47a1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: this.model.examinationForm.mucosa,
            enabled: false,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Other',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff0d47a1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: this.model.examinationForm.otherBody,
            enabled: false,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Enter text',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
      ],
    );
  }
}
