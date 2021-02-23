import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/sign_in_view_model.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 350.0,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/waves.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    "Verify Your Number",
                                    style: TextStyle(
                                        fontSize: (28 / 375.0) *
                                            MediaQuery.of(context).size.width,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        height: 1.5),
                                  ),
                                  Text(
                                    'Please enter Your mobile Number to',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    'receive a verification code. message and data',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    'rates may apply',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                  _buildPhoneField(model),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                  _buildContinueButton(context, model),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                ],
                              ),
                            ),
                          ],
                        ),
                        _buildLogo(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Padding _buildPhoneField(SignInViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        children: [
          Expanded(
            child: new TextFormField(
              initialValue: '+84',
              enabled: false,
              decoration: InputDecoration(
                filled: false,
                errorText: model.phoneNum.error,
                contentPadding: new EdgeInsets.symmetric(
                  vertical: 14.2,
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                prefixIcon: Icon(
                  FontAwesomeIcons.globe,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            flex: 2,
          ),
          new SizedBox(
            width: 10.0,
          ),
          new Expanded(
            child: TextFormField(
              controller: model.phoneNo,
              onChanged: (value) => model.changePhoneNum(value),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 10,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                errorText: model.phoneNum.error,
                counterText: "",
                hintText: 'Enter your Number',
                filled: false,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }

  Container _buildContinueButton(BuildContext context, SignInViewModel model) {
    return Container(
      height: (56 / 812.0) * MediaQuery.of(context).size.height,
      child: RaisedButton(
        onPressed: () {
          model.storePhone(context);
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: (300 / 375.0) * MediaQuery.of(context).size.width,
                minHeight: (50 / 812.0) * MediaQuery.of(context).size.height),
            alignment: Alignment.center,
            child: Text(
              "Continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: (18 / 375.0) * MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildLogo() {
    return Positioned(
      left: 0,
      top: 72,
      right: 0,
      child: Container(
        width: 150,
        height: 150,
        child: Image.asset(
          'assets/logo_doctor.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
