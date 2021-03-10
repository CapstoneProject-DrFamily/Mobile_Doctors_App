import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/share/timeline_process.dart';
import 'package:mobile_doctors_apps/screens/view_model/timeline_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class BaseTimeLine extends StatelessWidget {
  final String transactionId;
  BaseTimeLine({@required this.transactionId});

  @override
  Widget build(BuildContext contextA) {
    return BaseView<TimeLineViewModel>(builder: (contextB, child, model) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: MainColors.blueBegin),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            model.index == 1
                ? Container(
                    child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          await model.skipTransaction(transactionId);
                          model.changeIndex(2);
                        },
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
                : Container(),
          ],
        ),
        body: Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: timelineProcess(contextB, model.index),
                ),
                Expanded(
                    child: model.buildWidget(model.index, model, transactionId))
              ],
            )),
      );
    });
  }
}
