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
          ))),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No data',
                style: TextStyle(color: Colors.white),
              ),
            )),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // collapsed: Text('See details'),
            expanded: Column(
              children: [
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
                            'Diagnose / Conclusion',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: this.model.examinationForm.conclusion,
                            maxLines: 5,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Enter your text'),
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                    style: TextStyle(fontSize: 18),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2.1 ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        'Vital Signs',
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
              buildAnthropometricIndex("Pulse", "...", model, "pulseRate"),
              // buildErrorMessage(),
              buildAnthropometricIndex(
                  "Temperature", "Celsius", model, "temperature"),
              buildAnthropometricIndex(
                  "Blood Pressure", "...", model, "bloodPressure"),
              buildAnthropometricIndex(
                  "Respiratory Rate", "...", model, "respiratoryRate"),
              buildAnthropometricIndex("Weight", "kg", model, "weight"),
              buildAnthropometricIndex("Height", "cm", model, "height"),
              buildAnthropometricIndex("BMI", "...", model, "BMI"),
              buildAnthropometricIndex(
                  "Hips", "...", model, "waistCircumference"),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          style: TextStyle(fontSize: 18),
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
                initialValue: this.model.getFieldNumber(field) != null
                    ? this.model.getFieldNumber(field).toStringAsFixed(1)
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Eye Sight',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No glasses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEyeExaminationForm("Left Eye", "0 ~ 10", model, "leftEye"),
              buildEyeExaminationForm("Right Eye", "0 ~ 10", model, "rightEye"),
              Text(
                'With glasses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Paraclinical',
                  style: TextStyle(
                    fontSize: 18,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  'Full body',
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
            'Mucosocutaneous',
            style: TextStyle(fontSize: 18),
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
            style: TextStyle(fontSize: 18),
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
