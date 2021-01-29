import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/helper/StatefulWrapper.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/sample_pop_up_view_model.dart';

class SamplePopUp extends StatelessWidget {
  List<BloodParameter> list;
  SamplePopUp({Key key, @required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<SamplePopUpViewModel>(
      builder: (context, child, model) {
        return StatefulWrapper(
          onInit: () {
            model.loadParameter(list);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        model.listParameter[index].name,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Checkbox(
                                  value: model.listParameter[index].isCheck
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    model.changeCheck(
                                        model.listParameter[index].name, value);
                                  },
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
                    Navigator.pop(context, model.listParameter);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AnalyzePage()));
                  },
                  child: Text('Add')),
            ],
          ),
        );
      },
    );
  }
}
