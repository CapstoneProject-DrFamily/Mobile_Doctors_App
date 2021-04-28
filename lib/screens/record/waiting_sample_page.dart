import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/waiting_sample_view_model.dart';
import 'package:mobile_doctors_apps/themes/colors.dart';

class WaitingSamplePage extends StatelessWidget {
  final String transactionId;
  WaitingSamplePage({@required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return BaseView<WaitingSampleViewModel>(
      builder: (context, child, model) {
        return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   centerTitle: true,
            //   leading: new IconButton(
            //     icon: new Icon(Icons.arrow_back_ios, color: Color(0xff0d47a1)),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            //   title: Text(
            //     "Awaiting Sample",
            //     textAlign: TextAlign.center,
            //     style: GoogleFonts.varelaRound(
            //       fontWeight: FontWeight.w600,
            //       fontSize: 20,
            //       color: Color(0xff0d47a1),
            //     ),
            //   ),
            // ),
            body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: pathPainter(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(50),
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "This transaction has been temporarily paused.",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "Waiting for test results",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.asset('assets/onBoardDoc.png'),
                      )),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0, 1],
                            colors: [MainColors.blueBegin, MainColors.blueEnd],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                          )),
                      child: Center(
                        child: Text(
                          "Continue checking",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      model.continueChecking(context, transactionId);
                    },
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.blue
                        .withOpacity(0), //You can make this transparent
                    elevation: 0.0, //No shadow
                  ),
                ),
              ],
            ),
          ],
        )
            // Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/onBoardDoc.png"))),
            //   child: Center(
            //     child: Text('sa'),
            //   ),
            // ),
            );
      },
    );
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = MainColors.defaultColor.withOpacity(0.3);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
