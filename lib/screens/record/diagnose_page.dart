import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/diagnose_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class DiagnosePage extends StatelessWidget {
  final TimeLineViewModel timelineModel;
  final String transactionId;
  final _formKey = GlobalKey<FormState>();

  DiagnosePage({@required this.timelineModel, @required this.transactionId});
  @override
  Widget build(BuildContext context) {
    return BaseView<DiagnosePageViewModel>(builder: (context, child, model) {
      return FutureBuilder(
          future: model.fetchData(transactionId, timelineModel),
          builder: (context, snapshot) {
            if (model.init) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.white.withOpacity(0.6), BlendMode.dstATop),
                          image: AssetImage('assets/images/result.jpg'),
                        )),
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Form(
                            key: _formKey,
                            child: Container(
                              height: double.infinity,
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
                                        Container(
                                          decoration: BoxDecoration(
                                              color: MainColors.blueBegin
                                                  .withOpacity(0.6),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40),
                                                  topRight:
                                                      Radius.circular(40))),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Padding(
                                            padding: !model.keyboard
                                                ? EdgeInsets.only(top: 85.0)
                                                : EdgeInsets.only(top: 10),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0,
                                                            left: 20,
                                                            right: 20,
                                                            top: 20),
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Diagnose / Conclusion',
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xff0d47a1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          (model.listChooseModel
                                                                      .length ==
                                                                  0)
                                                              ? Container()
                                                              : Wrap(
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  children: [
                                                                    for (var item
                                                                        in model
                                                                            .listChooseModel)
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                10,
                                                                            left:
                                                                                5),
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                5,
                                                                            horizontal:
                                                                                10),
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxWidth:
                                                                              MediaQuery.of(context).size.width * 0.7,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                          color:
                                                                              Color(0xff0d47a1),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Text(
                                                                                item,
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                model.removeDisease(item);
                                                                              },
                                                                              child: Icon(
                                                                                EvaIcons.closeOutline,
                                                                                color: Colors.white,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (model
                                                                        .listChooseModel
                                                                        .length ==
                                                                    0) {
                                                                  return "Please enter your Diagnose";
                                                                }
                                                                return null;
                                                              },
                                                              controller: model
                                                                  .diagnoseConclusionController,
                                                              maxLines: 1,
                                                              decoration: InputDecoration
                                                                  .collapsed(
                                                                      hintText:
                                                                          'Enter your text'),
                                                              onTap: () {
                                                                model
                                                                    .initSearch();
                                                              },
                                                              onChanged:
                                                                  (query) {
                                                                model
                                                                    .searchDiagnoseFunc(
                                                                        query);
                                                              },
                                                              onSaved:
                                                                  (query) {},
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  (model.isLoading)
                                                      ? Container(
                                                          child:
                                                              CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        )
                                                      : (model.keyboard &&
                                                              (model.listDiseaseModel
                                                                      .isNotEmpty ||
                                                                  model
                                                                      .listDiseaseSearchModel
                                                                      .isNotEmpty))
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 25,
                                                                      right:
                                                                          25),
                                                              child: MediaQuery
                                                                  .removePadding(
                                                                context:
                                                                    context,
                                                                removeTop: true,
                                                                child: ListView
                                                                    .separated(
                                                                  separatorBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          Divider(
                                                                    height:
                                                                        0.01,
                                                                  ),
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: (model.changeList)
                                                                      ? model
                                                                          .listDiseaseSearchModel
                                                                          .length
                                                                      : model
                                                                          .listDiseaseModel
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        title: Transform
                                                                            .translate(
                                                                          offset: Offset(
                                                                              -7,
                                                                              0),
                                                                          child: Text((model.changeList)
                                                                              ? '${model.listDiseaseSearchModel[index].diseaseCode}-${model.listDiseaseSearchModel[index].diseaseName}'
                                                                              : '${model.listDiseaseModel[index].diseaseCode} - ${model.listDiseaseModel[index].diseaseName}'),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          (model.changeList)
                                                                              ? model.chooseDisease(model.listDiseaseSearchModel[index].diseaseCode, model.listDiseaseSearchModel[index].diseaseName, 1)
                                                                              : model.chooseDisease(model.listDiseaseModel[index].diseaseCode, model.listDiseaseModel[index].diseaseName, 2);
                                                                          print(
                                                                              "choose ${model.changeList}");
                                                                          model.diagnoseConclusionController.text =
                                                                              "";
                                                                          FocusScope.of(context)
                                                                              .requestFocus(new FocusNode());
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          : Container(
                                                              child: Text(""),
                                                            ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Doctor Advice',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xff0d47a1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: TextField(
                                                              onTap: () {
                                                                model
                                                                    .changeField();
                                                              },
                                                              controller: model
                                                                  .doctorAdviceController,
                                                              maxLines: 5,
                                                              decoration: InputDecoration
                                                                  .collapsed(
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
                                        ),
                                        Visibility(
                                          visible:
                                              !model.keyboard ? true : false,
                                          child: Positioned(
                                            top: -66,
                                            child: CircleAvatar(
                                              radius: 73,
                                              backgroundColor: MainColors
                                                  .blueBegin
                                                  .withOpacity(0.5),
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
                                          visible:
                                              !model.keyboard ? true : false,
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
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      await model
                                                          .confirmDiagnose(
                                                              timelineModel,
                                                              context);
                                                      timelineModel
                                                          .changeIndex(3);
                                                    }
                                                  },
                                                  child: !model.loadingNext
                                                      ? Text(
                                                          'Next',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Container(
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
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
              );
          });
    });
  }
}
