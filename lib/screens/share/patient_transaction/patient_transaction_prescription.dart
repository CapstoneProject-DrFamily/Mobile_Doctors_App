import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/patient_transaction_prescription_view_model.dart';

class TransactionPrescriptionScreen extends StatelessWidget {
  final String transactionId;
  TransactionPrescriptionScreen({@required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionPrescriptionViewModel>(
        builder: (context, child, model) {
      return Scaffold(
        body: FutureBuilder(
          future: model.fetchData(transactionId),
          builder: (context, snapshot) {
            if (model.init) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildMedicineList(model),
                  ],
                ),
              );
          },
        ),
      );
    });
  }

  Container buildMedicineList(TransactionPrescriptionViewModel model) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: model.list.length == null || model.list.length == 0
                ? true
                : false,
            child: Text(
              'No data',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
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
                                model.list[index].medicine.medicineName,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            // collapsed: Text('See details'),
                            expanded: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 3,
                                          color: Colors.white,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Visibility(
                                          visible: model.list[index]
                                                          .morningQuantity !=
                                                      0 &&
                                                  model.list[index]
                                                          .morningQuantity !=
                                                      null
                                              ? true
                                              : false,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Morning',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Text(
                                                    model.list[index]
                                                        .morningQuantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  model.list[index].type,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Visibility(
                                          visible:
                                              model.list[index].noonQuantity !=
                                                          0 &&
                                                      model.list[index]
                                                              .noonQuantity !=
                                                          null
                                                  ? true
                                                  : false,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Noon',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Text(
                                                    model.list[index]
                                                        .noonQuantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  model.list[index].type,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Visibility(
                                          visible: model.list[index]
                                                          .afternoonQuantity !=
                                                      0 &&
                                                  model.list[index]
                                                          .afternoonQuantity !=
                                                      null
                                              ? true
                                              : false,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Afternoon',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Text(
                                                    model.list[index]
                                                        .afternoonQuantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  model.list[index].type,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: Colors.white,
                                          indent: 10,
                                          endIndent: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  model
                                                      .list[index].totalQuantity
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.list[index].type,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Days',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  model.list[index].totalDays
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'days',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))),
                            tapHeaderToExpand: true,
                            hasIcon: true,
                            iconColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Note',
                  style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.description == null ? '' : "- ${model.description}",
                  style: TextStyle(
                    color: Color(0xff0d47a1),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
