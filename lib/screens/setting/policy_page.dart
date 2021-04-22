import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/policy_view_model.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PolicyViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "App Policy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff0d47a1),
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: FutureBuilder(
              future: model.fetchPolicy(),
              builder: (context, snapshot) {
                if (model.init) {
                  return Center(child: CircularProgressIndicator());
                } else
                  return SingleChildScrollView(
                    child: Container(
                      child: Html(
                        data: model.htmlData == null ? "" : model.htmlData,
                      ),
                    ),
                  );
              }),
        );
      },
    );
  }
}
