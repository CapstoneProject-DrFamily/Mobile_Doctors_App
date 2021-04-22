import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_doctors_apps/screens/setting/policy_page.dart';
import 'package:mobile_doctors_apps/screens/share/base_view.dart';
import 'package:mobile_doctors_apps/screens/view_model/setting_view_model.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseView<SettingViewModel>(
      builder: (context, child, model) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                _buildHeader(context, model),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PolicyPage(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(Icons.policy),
                          title: Text("Policy"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                model.signOut(context);
                              },
                              child: Text(
                                'Log out',
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildHeader(BuildContext context, SettingViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLeftSideHeader(model),
          _buildRightSideHeader(context, model),
        ],
      ),
    );
  }

  Expanded _buildRightSideHeader(BuildContext context, SettingViewModel model) {
    return Expanded(
      flex: 4,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.username != null ? model.username : '',
              style: TextStyle(color: Colors.blue[900], fontSize: 28),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                model.seeDetail(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'See Profile',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildLeftSideHeader(SettingViewModel model) {
    return Expanded(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        backgroundImage: model.image != null
            ? NetworkImage(model.image)
            : NetworkImage(
                'https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg'),
      ),
      flex: 2,
    );
  }
}
