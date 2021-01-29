import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_page_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class SamplePage extends StatelessWidget {
  int _processIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<SamplePageViewModel>(builder: (context, child, model) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage('assets/images/sample.jpg'),
            )),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: MainColors.blueBegin),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Container(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Skip this step',
                        style: TextStyle(
                            color: MainColors.blueBegin,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
          backgroundColor: Colors.transparent,
          body: buildListParameter(context, model),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.lightBlue[600],
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        title: Center(child: new Text("Chọn chỉ số")),
                        content: Container(
                          width: 300,
                          height: 400,
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: model.listParameter.length,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(child: TextField()),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    model.listParameter[index]
                                                        .name,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Checkbox(
                                              value: false,
                                              onChanged: (value) {},
                                            ),
                                          )

                                          // Expanded(
                                          //   flex: 3,
                                          //   child: ListTile(
                                          //     leading: SvgPicture.asset(
                                          //         'assets/icons/pills.svg',
                                          //         width: 40,
                                          //         height: 40),
                                          //     title: Text('Paracetamol'),
                                          //     subtitle: Text('Description'),
                                          //   ),
                                          // ),
                                          // Expanded(
                                          //     child: new Radio(
                                          //   value: 0,
                                          // )),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                              ]);
                            },
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          FlatButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => AnalyzePage()));
                              },
                              child: Text('Add')),
                        ],
                      ));
            },
          ),
        ),
      );
    });
  }

  Container buildListParameter(
      BuildContext context, SamplePageViewModel model) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          timelineProcess(context, _processIndex),
          SizedBox(
            height: 50,
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
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        color: MainColors.blueBegin.withOpacity(1),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text(
                                  'Xét nghiệm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                            Expanded(
                                child: Center(
                                    child: Text('Kết quả',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)))),
                            Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text('Trị số BT',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: model.listCheck.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: index % 2 == 0
                                    ? MainColors.blueBegin.withOpacity(0.1)
                                    : MainColors.blueBegin.withOpacity(1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                            child: Text(
                                          model.listParameter[index].name,
                                          style: TextStyle(fontSize: 18),
                                        ))),
                                    Expanded(
                                        child: Center(
                                            child: TextField(
                                      decoration: InputDecoration(
                                          hintText: '0.0',
                                          border: InputBorder.none),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                            18, // This is not so important
                                      ),
                                    ))),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                            child: Text(
                                          model.listParameter[index].normal,
                                          style: TextStyle(fontSize: 18),
                                        ))),
                                  ]),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
