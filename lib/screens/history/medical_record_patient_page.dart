import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/medical_care_patient_history_view_model.dart';

class MedicalCarePatientHistory extends StatelessWidget {
  final int patientId;
  MedicalCarePatientHistory({@required this.patientId});
  @override
  Widget build(BuildContext context) {
    return BaseView<MedicalCarePatientHistoryViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.initHistory(patientId),
          builder: (context, snapshot) {
            if (!model.isFirst) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back_ios,
                          color: Color(0xff0d47a1)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      "Patient History Record",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          child: (model.loadingList)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (model.isNotHave)
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/prescription.svg',
                                            width: 80,
                                            height: 80,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Not Found Any Records",
                                            style: GoogleFonts.varelaRound(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                color: Color(0xff0d47a1),
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: model.listTransaction.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            model.chooseTransaction(
                                                context,
                                                model.listTransaction[index]
                                                    .transactionID,
                                                model.listTransaction[index]
                                                    .status,
                                                patientId);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            color: (index % 2 == 0)
                                                ? Colors.white
                                                : Colors.grey[100],
                                            child: CustomListItemTwo(
                                              serviceType: model
                                                  .listTransaction[index]
                                                  .serviceName,
                                              dateTimeBook: DateFormat(
                                                      "dd-MM-yyyy - HH:mm")
                                                  .format(DateTime.parse(model
                                                      .listTransaction[index]
                                                      .dateTimeEnd))
                                                  .toString(),
                                              location: model
                                                  .listTransaction[index]
                                                  .location
                                                  .split(';')[1]
                                                  .split(':')[1],
                                              price: NumberFormat.currency(
                                                      locale: 'vi')
                                                  .format(model
                                                      .listTransaction[index]
                                                      .servicePrice),
                                              patientName: model
                                                  .listTransaction[index]
                                                  .patientName,
                                              status: model
                                                  .listTransaction[index]
                                                  .status,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      )
                    ],
                  ),
                );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      },
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.serviceType,
    this.dateTimeBook,
    this.location,
    this.patientName,
    this.price,
    this.status,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String patientName;
  final String price;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$serviceType',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff0d47a1),
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
        Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Text(
              '$dateTimeBook',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.black54,
              size: 17,
            ),
            const Padding(padding: EdgeInsets.only(right: 7.0)),
            Expanded(
              child: Text(
                '$location',
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Patient: $patientName',
          textAlign: TextAlign.left,
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff0d47a1),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.serviceType,
    this.dateTimeBook,
    this.location,
    this.patientName,
    this.price,
    this.status,
  }) : super(key: key);

  final String serviceType;
  final String dateTimeBook;
  final String location;
  final String patientName;
  final String price;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        // height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  serviceType: serviceType,
                  dateTimeBook: dateTimeBook,
                  location: location,
                  price: price,
                  patientName: patientName,
                  status: status,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
