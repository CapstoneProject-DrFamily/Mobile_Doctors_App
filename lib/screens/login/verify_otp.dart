import 'package:flutter/material.dart';
import 'package:mobile_doctors_apps/helper/fire_base_link.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/verify_otp_view_model.dart';

class VerifyOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyOTPViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.white),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            (20 / 375.0) * MediaQuery.of(context).size.width),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            color: Colors.white,
                            height: 350.0,
                            // width: double.infinity,
                            child: Image.network(
                              ImagesLinks.otpVerify,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "OTP Verification",
                            style: TextStyle(
                                fontSize: (28 / 375.0) *
                                    MediaQuery.of(context).size.width,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.5),
                          ),
                          Text(
                            'We sent your code to +84${model.phoneNum}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.009),
                          _buildTimer(model),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          _buildOtpFrom(context, model),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          _buildButtom(context, model),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          (model.hideResend)
                              ? Text('')
                              : GestureDetector(
                                  onTap: () {
                                    model.startTimer();
                                  },
                                  child: Text(
                                    'Resend OTP Code',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.lightBlue),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text(''), // You can add title here
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.blue
                      .withOpacity(0), //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container _buildButtom(BuildContext context, VerifyOTPViewModel model) {
    return Container(
      height: (56 / 812.0) * MediaQuery.of(context).size.height,
      child: RaisedButton(
        onPressed: () {
          // model.submitOTP(context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {}),
              (Route<dynamic> route) => false);
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
                maxWidth: (350 / 375.0) * MediaQuery.of(context).size.width,
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

  Form _buildOtpFrom(BuildContext context, VerifyOTPViewModel model) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildOtpField(context, 1, model),
          _buildOtpField(context, 2, model),
          _buildOtpField(context, 3, model),
          _buildOtpField(context, 4, model),
          _buildOtpField(context, 5, model),
          _buildOtpField(context, 6, model),
        ],
      ),
    );
  }

  SizedBox _buildOtpField(
      BuildContext context, int field, VerifyOTPViewModel model) {
    return SizedBox(
      width: (45 / 375) * MediaQuery.of(context).size.width,
      child: TextFormField(
        maxLength: 1,
        autofocus: (field == 1) ? true : false,
        onChanged: (value) {
          model.changeFocusNode(field, value);
        },
        focusNode: model.nextFocusNode(field),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: (10 / 375) * MediaQuery.of(context).size.width),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }

  Row _buildTimer(VerifyOTPViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: TextStyle(color: Colors.grey[600]),
        ),
        Text(
          "00:${model.start}",
          style: TextStyle(color: Colors.lightBlue),
        ),
      ],
    );
  }
}
