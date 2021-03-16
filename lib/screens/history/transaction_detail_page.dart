import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/helper/common.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/transaction_detail_view_model.dart';

class TransactionDetailPage extends StatelessWidget {
  final String transactionId;
  TransactionDetailPage({@required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Transaction Detail',
              style: TextStyle(color: Color(0xff0d47a1)),
            ),
          ),
          body: FutureBuilder(
            future: model.fetchData(transactionId),
            builder: (contextC, snapshop) {
              if (model.init) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('ID:'),
                            ),
                            Flexible(
                              child: Chip(
                                label: Text(model.transaction.transactionId),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 8, left: 20),
                                      child: Icon(
                                        Icons.android,
                                        size: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 8),
                                      child: Text('Family Doctor'),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: (model.transaction.status == 3)
                                        ? Border.all(color: Colors.green)
                                        : Border.all(color: Colors.red),
                                  ),
                                  child: (model.transaction.status == 3)
                                      ? Text(
                                          "Done",
                                          style: GoogleFonts.varelaRound(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          "Cancel",
                                          style: GoogleFonts.varelaRound(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.red,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 20, left: 8),
                                    child: Text(Common.convertDate(
                                        model.transaction.dateStart)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Icon(Icons.arrow_downward_rounded),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 20, left: 8),
                                      child: Text(
                                        Common.convertDate(
                                            model.transaction.dateEnd),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          glowColor: Colors.amber,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // model.changeRating(rating);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Text('User like most : '),
                              Flexible(
                                  child: Text(
                                      'Specialist skill, Professionalism, Price, other'))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    NetworkImage(model.profileUser.image),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.profileUser.fullName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(Common.getLocationName(
                                        model.transaction.location)),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 60,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 3,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Chip(
                                                    label: Text(
                                                        'Difficulty sleeping'),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                'Service Info',
                                style: TextStyle(
                                    color: Color(0xff0d47a1), fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Name'),
                                    Text(model.service.serviceName)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price'),
                                    Text(Common.convertPrice(
                                        model.service.servicePrice))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            },
          ),
        );
      },
    );
  }
}
