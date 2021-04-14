import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_page_view_model.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class SamplePage extends StatelessWidget {
  final TimeLineViewModel timelineModel;
  final String transactionId;

  SamplePage({@required this.timelineModel, @required this.transactionId});
  Widget build(BuildContext context) {
    return BaseView<SamplePageViewModel>(builder: (context, child, model) {
      return FutureBuilder(
        future: model.fetchData(transactionId, timelineModel),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    image: AssetImage('assets/images/sample.jpg'),
                  )),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: buildListParameter(context, model),
              ),
            ),
          );
        },
      );
    });
  }

  Container buildListParameter(
      BuildContext context, SamplePageViewModel model) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: MainColors.blueBegin.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 85),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ExpandablePanel(
                              header: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Take Sample',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '1.Blood Test',
                                              style: TextStyle(
                                                  color: Color(0xff0d47a1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                              child: Checkbox(
                                                value: model.listCheck.contains(
                                                        "Serum biochemistry")
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  print(value);

                                                  model.changeCheck(
                                                      "Serum biochemistry");
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: model.listCheck
                                                .contains("Serum biochemistry")
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SafeArea(
                                                      child: new Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          new ListTile(
                                                            leading: new Icon(
                                                                Icons.camera),
                                                            title: new Text(
                                                                'Camera'),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);

                                                              await model
                                                                  .getImageFromCamera(
                                                                      "Serum biochemistry");
                                                            },
                                                          ),
                                                          new ListTile(
                                                            leading: new Icon(
                                                                Icons.image),
                                                            title: new Text(
                                                                'Gallery'),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);

                                                              await model
                                                                  .getImageFromGallery(
                                                                      "Serum biochemistry");
                                                              print("oke");
                                                            },
                                                          ),
                                                          (model.imageSerumbiochemistry !=
                                                                  null)
                                                              ? new ListTile(
                                                                  leading: new Icon(
                                                                      EvaIcons
                                                                          .closeOutline),
                                                                  title: new Text(
                                                                      'Delete Image'),
                                                                  onTap:
                                                                      () async {
                                                                    model.deleteImage(
                                                                        "Serum biochemistry");
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: (model
                                                        .imageSerumbiochemistry !=
                                                    null)
                                                ? Image.network(
                                                    model
                                                        .imageSerumbiochemistry,
                                                    width: 200,
                                                    height: 250,
                                                    fit: BoxFit.fill)
                                                : Container(
                                                    width: 200,
                                                    height: 250,
                                                    color: Colors.grey,
                                                    child:
                                                        Icon(Icons.camera_alt),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2.Urine Test',
                                              style: TextStyle(
                                                  color: Color(0xff0d47a1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Flexible(
                                              child: Checkbox(
                                                value: model.listCheck.contains(
                                                        "Urine biochemistry")
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  print(value);

                                                  model.changeCheck(
                                                      "Urine biochemistry");
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: model.listCheck
                                                .contains("Urine biochemistry")
                                            ? true
                                            : false,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SafeArea(
                                                      child: new Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          new ListTile(
                                                            leading: new Icon(
                                                                Icons.camera),
                                                            title: new Text(
                                                                'Camera'),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);

                                                              await model
                                                                  .getImageFromCamera(
                                                                      "Urine biochemistry");
                                                            },
                                                          ),
                                                          new ListTile(
                                                            leading: new Icon(
                                                                Icons.image),
                                                            title: new Text(
                                                                'Gallery'),
                                                            onTap: () async {
                                                              Navigator.pop(
                                                                  context);

                                                              await model
                                                                  .getImageFromGallery(
                                                                      "Urine biochemistry");
                                                              print("oke");
                                                            },
                                                          ),
                                                          (model.imageUrinebiochemistry !=
                                                                  null)
                                                              ? new ListTile(
                                                                  leading: new Icon(
                                                                      EvaIcons
                                                                          .closeOutline),
                                                                  title: new Text(
                                                                      'Delete Image'),
                                                                  onTap:
                                                                      () async {
                                                                    model.deleteImage(
                                                                        "Urine biochemistry");
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: (model
                                                        .imageUrinebiochemistry !=
                                                    null)
                                                ? Image.network(
                                                    model
                                                        .imageUrinebiochemistry,
                                                    width: 200,
                                                    height: 250,
                                                    fit: BoxFit.fill)
                                                : Container(
                                                    width: 200,
                                                    height: 250,
                                                    color: Colors.grey,
                                                    child:
                                                        Icon(Icons.camera_alt),
                                                  ),
                                          ),
                                        ),
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
                          SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -66,
                    child: CircleAvatar(
                      radius: 73,
                      backgroundColor: MainColors.blueBegin.withOpacity(0.5),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70,
                        child: Container(
                          child: Image.asset(
                            'assets/images/time_line_2.png',
                            width: 120,
                            // color: Colors.red,
                          ),

                          // SvgPicture.asset(
                          //   'assets/icons/medical-file.svg',
                          //   height: 80,
                          //   width: 80,
                          // ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: MainColors.blueBegin.withOpacity(0.8),
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            model.saveSample(context, timelineModel);
                          },
                          child: !model.isLoading
                              ? Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                )
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
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
          ),
        ],
      ),
    );
  }
}
